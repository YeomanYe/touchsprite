socket = require "luasocket"

function download (host, file)
    local c = assert(socket.connect(host, 80))
    local count = 0      -- counts number of bytes read
    c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
    while true do
       local s, status = receive(c)
       count = count + string.len(s)
       if status == "closed" then break end
    end
    c:close()
    print(file, count)
end


function receive (connection)
    connection:timeout(0)    -- do not block
    local s, status = connection:receive(2^10)
    if status == "timeout" then
       coroutine.yield(connection)
    end
    return s, status
end


threads = {}      -- list of all live threads


function get (host, file)
    -- create coroutine
    local co = coroutine.create(function ()
       download(host, file)
    end)
    -- insert it in the list
    table.insert(threads, co)
end

-- 简单协程版本
function dispatcher ()
    while true do
       local n = table.getn(threads)
       if n == 0 then break end    -- no more threads to run
       for i=1,n do
           local status, res = coroutine.resume(threads[i])
           if not res then   -- thread finished its task?
              table.remove(threads, i)
              break
           end
       end
    end
end

-- 非阻塞IO，当IO创建完全，阻塞协程切换直到完成一个协程，避免协程之间的切换造成不必要的开销
function dispatcher ()
    while true do
       local n = table.getn(threads)
       if n == 0 then break end    -- no more threads to run
       local connections = {}
       for i=1,n do
           local status, res = coroutine.resume(threads[i])
           if not res then   -- thread finished its task?
              table.remove(threads, i)
              break
           else   -- timeout
              table.insert(connections, res)
           end
       end
       if table.getn(connections) == n then
           socket.select(connections)
       end
    end
end


host = "www.w3c.org"
 
get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host,
    "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")
 
dispatcher()      -- main loop