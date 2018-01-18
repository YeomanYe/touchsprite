--Object为所有对象的上级
Object = {}

--创建现有对象副本的方法
function Object:clone()
 --成为新对象的表
 local object = {}
 --复制表元素
 for k,vin pairs(self) do
  object[k] = v
end

 --设定元表
 --虽然名字叫clone但并不是复制而是向自身转发
 --为了将对类等的修改反映出来
 setmetatable(object, {__index = self)

 return object
end

--以某个对象为原型创建新的对象
--新对象通过initialize方法进行初始化
--允许类似基于类编程的用法
function Object:new(...)
 --成为新对象的表
 local object = {}

 --找不到的方法将搜索目标设定为self
 setmetatable(object, {__index = self})

 --和Ruby一样，初始化时调用initialize方法
 --(...)表示将所有参数原样传递
 object:initialize(...)

 return object
end

--实例初始化函数
function Object:initialize(...)
 --默认不进行任何操作
end

--为了本来不需要进行的类似类的操作而准备原型
Class = Object:new()

--[[ 面向对象式编程
-- 首先创建新的原型
-- 创建表示“点”的原型Point
Point = Class:new()

-- Point实例初始化方法
-- 设定坐标x和y
function Point:initialize(x, y)
  self.x = x
  self.y = y
end

-- 定义Point类的方法magnitude
-- 求与原点之间的距离
function Point:magnitude()
  return math.sqrt(self.x^2 + self.y^2)
end

-- 创建Point类的实例
-- x = 3, y = 4
p = Point:new(3,4)

-- 确认是否设定了成员
print("p.x = ", p.x) --> p.x = 3
print("p.y = ", p.y) --> p.x = 4

-- 计算magnitude()
-- 由勾股定理可求得结果为5
print(p:magnitude()) --> 5

-- 继承了Point的Point3D类的定义
-- 为了创建子类要对类进行clone操作
Point3D = Point:clone()

-- Point3D对象的初始化方法
-- 由于变成三维空间因此增加了z轴上的值
function Point3D:initialize(x, y, z)
  -- 调用超类的initialize进行初始化
  -- 必须要指定一个self有点不美观
  Point.initialize(self, x, y)
  -- Point3D类的扩展部分
  self.z = z
end

-- Point3D用的magnitude()方法
function Point3D:magnitude()
  return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

-- 创建Point3D实例
p3 = Point3D:new(1,2,3)

-- 属性检查
print("p3.x = ", p3.x) --> 1
print("p3.y = ", p3.y) --> 2
print("p3.z = ", p3.z) --> 3

-- 调用magnitude方法
print(p3:magnitude()) --> 3.7416573867739

-- 创建一个p3的副本
p4 = p3:clone()
-- 属性检查
print("p4.x = ", p4.x) --> 1
print("p4.y = ", p4.y) --> 2
print("p4.z = ", p4.z) --> 3

-- 调用magnitude方法的结果相同
print(p4:magnitude()) --> 3.7416573867739
]]