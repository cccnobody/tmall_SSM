# tmall_SSM

前言：该项目是根据how2j的实战教程，在此感谢站长，然后加上自己的一点想法，课余时间模仿制作出来的。所以会有点粗糙，但是基本的功能如一整个购物的流程还有后台对订单以及管理商品的功能还是有的。用的是SSM框架，所以说前后端没有分离，现在也没有时间和精力再去学springboot了，毕竟前端更适合我，蛤蛤。趁着现在还有点时间，赶紧把项目git上来，接下来还要准备别的了。 

## 基于SSM的仿P站风格天猫商城页面预览

**前台首页预览**

<http://119.23.51.83:8080/tmall_ssm/forehome>

![Markdown](http://prcfme0aj.bkt.clouddn.com/%E5%89%8D%E5%8F%B0%E9%A6%96%E9%A1%B5.PNG)

**后台首页预览**

<http://119.23.51.83:8080/tmall_ssm/admin_category_list>

![Markdown](http://prcfme0aj.bkt.clouddn.com/%E5%90%8E%E5%8F%B0%E9%A6%96%E9%A1%B5.PNG)

## 开发环境

MySQL使用5.7，tomcat 8.5，jdk1.8。不敢保证可以向下兼容，所以你懂的。开发工具使用IDEA，确实是比eclipse好用，但是eclipse比较轻便，看个人选择吧，影响不大。

## 开发流程

## 一、需求分析，根据功能确定页面

前台：首页、分类页、查询结果页、产品页、结算页面、支付页面、支付成功页面、购物车页面、我的订单页面、确认收货页面、确认收货成功页面、进行评价页面、登录页面、注册页面。

后台： 分类管理、分类属性管理、产品管理、产品属性设置、产品图片管理、用户管理、订单管理。

## 二、数据表结构设计

表结构设计是围绕功能需求进行，如果表结构设计有问题，那么将会影响功能的实现。

###    1、    创建项目数据库并将数据库编码设置为utf-8.

DROP DATABASE IF EXISTS tmall_ssm;

CREATE DATABASE tmall_ssm DEFAULT CHARACTER SET utf8;

### 2、明确表的关系图（模仿天猫整站共需要9张表）

![Markdown](http://prcfme0aj.bkt.clouddn.com/%E8%A1%A8%E5%85%B3%E7%B3%BB.png)

### 3、由于表格与表格之间有依赖关系，所以需要先建立被外键指向的表，然后再建立其他表，最后将sql语句全部整合到一起，一次性全部执行。

## 四、后台管理查询功能

1、新建maven项目，准备本地仓库{user.home}/.m2/repository

![Markdown](http://prcfme0aj.bkt.clouddn.com/%E6%96%B0%E5%BB%BAmaven%E9%A1%B9%E7%9B%AE.png)

### 2、修改pom.xml（http://how2j.cn/k/tmall_ssm/tmall_ssm-1516/1516.html#nowhere）

![Markdown](http://prcfme0aj.bkt.clouddn.com/porn.png)

然后新建Java源代码目录

###  3、在pojo包中建立实体类。声明对应的字段，然后生成对应的getter和setter。

###  4、 在mapper包中创建实体类对应的接口，声明方法。

###  5、在service包中创建实体类对应的接口，声明方法。（同上）虽然两个步骤重复了，但是Mapper是用来查询数据库的，Service是用来提供业务的，所以分开来。。

### 6、新建impl包，实现对应的接口。注解@Service声明当前类是一个Service类通过自动装配@Autowired引入Mapper类，然后就可以调用里面的方法。 

![Markdown](http://prcfme0aj.bkt.clouddn.com/CategorySerImpl.png)

### 7、新建一个Controller包。

 注解@Controller声明当前类是一个控制器
​	注解@RequestMapping("")表示访问的时候无需额外的地址
​	注解@Autowired把CategoryServiceImpl自动装配进了CategoryService 接口
​	注解@RequestMapping("admin_category_list") 映射admin_category_list路径的访问
​	在list方法中，通过categoryService.list()获取所有的Category对象，然后放在"cs"中，并服务端跳转到 		“admin/listCategory” 视图。
​	“admin/listCategory” 会根据后续的springMVC.xml 配置文件，跳转到 WEB-INF/jsp/admin/listCategory.jsp 文件

![Markdown](http://prcfme0aj.bkt.clouddn.com/cs.png)

这两个cs必须对应。引号内的名字可以自定义，相当于把上面的cs集合里面的值赋给下面。

### 8、新建***Mapper.xml(后续这一步骤可以使用逆向工程解决)

在resources目录下，新建mapper目录

右键mapper目录->New->File 新建文件CategoryMapper.xml
 **CategoryMapper.xml的namespace必须是com.how2java.tmall.mapper.CategoryMapper,以和[CategoryMapper](http://how2j.cn/k/tmall_ssm/tmall_ssm-1516/1516.html#step6434)保持一致。**
 CategoryMapper.xml声明了唯一的一条sql语句

### 9、在resources目录下新建log4j.properties。这个配置文件的作用是开启日志

### 10、在resources目录下新建jdbc.properties，此配置文件给出了访问数据库需要的必须信息。1. 驱动 2. url 3. 账号 4. 密码

### 11、在resources目录下新建applicationContext.xml。此配置文件做了如下工作

\1. 启动对注解的识别

\2. 指定对[jdbc.properties](http://how2j.cn/k/tmall_ssm/tmall_ssm-1516/1516.html#step6439)的引用

\3. 配置数据源 

\4. 配置Mybatis的SessionFactory，其中声明了别名，并且使用前面配置的数据源，扫描[CategoryMapper.xml](http://how2j.cn/k/tmall_ssm/tmall_ssm-1516/1516.html#step6435)配置文件

\5. 扫描Mapper类

### 12、在resource目录下新建springMVC.xml

\1. 开启注解的识别（指定某一个包）

2.开通静态资源的访问，否则访问图片，css,js等文件可能出错

\3. 视图定位 （访问的时候可以省略前缀和后缀）

\4. 对上传文件的解析

### 13、修改web.xml

1. 指定spring的配置文件为classpath下的applicationContext.xml
2. 设置中文过滤器
3. 指定spring mvc配置文件为classpath下的springMVC.xml

### 14、配置tomcat

### 15、思路图

![Markdown](http://prcfme0aj.bkt.clouddn.com/mind.png)

## 五、后台管理分页功能（后续使用插件开发这一功能）

### 1、新建一个Page.java，为分页提供必要的信息（看作一个JavaBean）

属性：
 int start; 开始位置
 int count; 每页显示的数量
 int total; 总共有多少条数据
 String param; 参数(这个属性在后续有用到，但是分类的分页查询里并没有用到，请忽略)

 	方法：
 getTotalPage 根据 每页显示的数量count以及总共有多少条数据total，计算出总共有多少页
 getLast 计算出最后一页的数值是多少
 isHasPreviouse 判断是否有前一页
 isHasNext 判断是否有后一页

### 2、修改CategoryMapper.xml，提供带分页的查询语句和获取总数的sql语句

### 3、修改CategoryMapper接口，提供查询的方法list(Page page)和获取总数的 方法total

### 4、修改CategoryService接口，同上。(**Mapper用来对数据库进行查询，service对业务操作**)

### 5、修改CategoryserviceImpl,实现接口，提供方法。

### 6、修改CategoryController

1. 为方法list增加参数Page用于获取浏览器传递过来的分页信息

2. categoryService.list(page); 获取当前页的分类集合

3. 通过categoryService.total(); 获取分类总数

4. 通过page.setTotal(total); 为分页对象设置总数

5. 把分类集合放在"cs"中

6. 把分页对象放在 "page”中

7. 跳转到listCategory.jsp页面

### 7、然后在adminPage.jsp中，通过EL表达式获取参数调用方法。

![Markdown](http://prcfme0aj.bkt.clouddn.com/houtai.png)

## 六、后台管理增加功能

### 1、需要对提交的分类图片以及分类图片名称进行是否为空的判断，需要使用js编写一个判断的函数。

### 2、在CategoryMapper.xml中新增加插入分类的SQL语句

### 3、在CategoryMapper和CategoryService中增加add方法

### 4、新增UploadedImageFile类 ，其中有一个MultipartFile 类型的属性，用于接受上传文件的注入。（需要引入jar包）

### 5、引入IamgeUtil工具类（直接复制源码即可）

### 6、修改CategoryController

1. #### add方法映射路径admin_category_add的访问

1.1 参数 Category c接受页面提交的分类名称

1.2 参数 session 用于在后续获取当前应用的路径

1.3 UploadedImageFile 用于接受上传的图片

2. #### 通过categoryService保存c对象

3. #### 通过session获取ControllerContext,再通过getRealPath定位存放分类图片的路径。

如果严格按照本教程的做法，使用idea中的tomcat部署的话，那么图片就会存放在:E:\project\tmall_ssm\target\tmall_ssm\img\category 这里

4. ### 根据分类id创建文件名

5. #### 如果/img/category目录不存在，则创建该目录，否则后续保存浏览器传过来图片，会提示无法保存

6. #### 通过UploadedImageFile 把浏览器传递过来的图片保存在上述指定的位置

7. #### 通过ImageUtil.change2jpg(file); 确保图片格式一定是jpg，而不仅仅是后缀名是jpg.

8. ### 客户端跳转到admin_category_list7、对于中文乱码的问题，统一交由[web.xml](http://how2j.cn/k/tmall_ssm/tmall_ssm-1516/1516.html#step6609) 中定义的org.springframework.web.filter.CharacterEncodingFilter来进行处理。同时要求jsp页面需要在页头写上

   ```java
   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8" import="java.util.*"%> 
   ```


## 七、后台管理删除

### 1、用于删除的超链，指向地址admin_category_delete,并且会传递当前分类对象的id过去。

```html
<a deleteLink="true"
	href="admin_category_delete?id=${c.id}">
	<span class="   glyphicon glyphicon-trash"></span>
</a>
```

 

### 2、进行删除操作之前，需要对所有的a链接进行监听，使用js判断是否要执行删除操作。

### 3、在CategoryMapper.xml中增加sql语句，分别在Category Mapper和CategoryService中增加删除的方法

### 4、修改CategoryServiceImpl类，重写删除方法

### 5、修改CategoryController

1. 映射路径admin_category_delete

2. 提供参数接受id注入

3. 提供session参数，用于后续定位文件位置

4. 通过categoryService删除数据

5. 通过session获取ControllerContext然后获取分类图片位置，接着删除分类图片

6. 客户端跳转到 admin_category_list

##     八、后台管理编辑

### 1、用于编辑的超链，指向地址admin_category_edit,并且会传递当前分类对象的id过去。

```html
<a
	href="admin_category_edit?id=${c.id}">
	<span class="glyphicon glyphicon-edit"></span>
</a>
```

### 2、编辑CategoryMapper.xml，增加通过id获取Category对象的sql语句

### 3、在Category Mapper和CategoryService中增加get方法

### 4、在CategoryServiceImpl中实现CategoryService接口，重写get方法

### 5、修改CategoryController

增加edit方法

1. 映射admin_category_edit路径的访问
2. 参数id用来接受注入
3. 通过categoryService.get获取Category对象
4. 把对象放在“c"上
5. 返回editCategory.jsp
6. 然后在editCategory.jsp中，通过el表达式显示分类的名称和分类的id

## 九、后台管理修改

### 1、编辑页面然后提交到路径admin_category_update处理，表单方式使用post方式。

### 2、在CategoryMapper.xml，增加修改sql语句。

### 3、在Category Mapper和CategoryService中增加update方法

### 4、修改CategoryController

#### 1. update 方法映射路径admin_category_update的访问

1.1参数 Category c接受页面提交的分类名称

1.2 参数 session 用于在后续获取当前应用的路径

1.3 UploadedImageFile 用于接受上传的图片

2. #### 通过categoryService更新c对象

3. #### 首先判断是否有上传图片，如果有上传，那么通过session获取ControllerContext,再通过getRealPath定位存放分类图片的路径。

如果严格按照本教程的做法，使用idea中的tomcat部署的话，那么图片就会存放在:E:\project\tmall_ssm\target\tmall_ssm\img\category 这里

4. #### 根据分类id创建文件名

5. #### 通过UploadedImageFile 把浏览器传递过来的图片保存在上述指定的位置

6. #### 通过ImageUtil.change2jpg(file); 确保图片格式一定是jpg，而不仅仅是后缀名是jpg.

7. #### 客户端跳转到admin_category_list


## 十、后台功能进行项目重构

### 1、分页方式

之前的分页方式都是需要提供开始位置、每页显示的数量、总共多少条数据几个属性，以及获取总数total等等方法，为了提高开发的效率，这里使用到一个Mybatis中的一个插件---pageHelper插件。

#### 1、  修改CategoryMapper.xml

\1. 去掉total SQL语句
 	\2. 修改list SQL语句，去掉其中的limit

####  2、修改CategoryMapper

\1. 去掉total()方法
 	\2. 去掉list(Page page)方法
 	\3. 新增list() 方法

##### 3、修改CategoryService（同上）

#### 4、修改CategoryServiceImpl

\1. 去掉total()方法
​	\2. 去掉list(Page page)方法
​	\3. 新增list() 方法

#### 5、修改CategoryController

修改list方法
​	\1. 通过分页插件指定分页参数

\2. 调用list() 获取对应分页的数据

\3. 通过PageInfo获取总数

#### 6、导入pagehelper-5.1.0-beta2.jar，jsqlparser-1.0.jar 的jar包，修改applicationContext.xml，增加对插件的配置

```java
<property name="plugins">
    <array>
        <bean class="com.github.pagehelper.PageInterceptor">
            <property name="properties">
                <!--使用下面的方式配置参数，一行配置一个 -->
                <value>
                </value>
            </property>
        </bean>
    </array>
</property>
```

### 2、分类的逆向工程

目前分类管理中Mybatis中相关类都是自己手动编写的，包括：Category.java, CategoryMapper.java和CategoryMapper.xml。尤其是CategoryMapper.xml里面主要是SQL语句，可以预见在接下来的开发任务中，随着业务逻辑的越来越复杂，SQL语句也会越来越复杂，进而导致开发速度降低，出错率增加，维护成本上升等问题。因此使用MybatisGenerator这个工具进行逆向工程的重构。

1、  MybatisGenerator插件是Mybatis官方提供的，这个插件存在一个固有的Bug，即当第一次生成了CategoryMapper.xml之后，再次运行会导致CategoryMapper.xml生成重复内容，而影响正常的运行。为了解决这个问题，需要自己写一个小插件类OverIsMergeablePlugin放在utils包下。至于实现的原理就不用管了。。。。

2、  在resource目录下创建generatorConfig.xml文件，为了正确使用本插件而提供必要的配置信息

\1. 使用OverIsMergeablePlugin插件 

```java
<plugin type="com.how2java.tmall.util.OverIsMergeablePlugin" />
```

\2. 在生成的代码中，不提供注释。如果提供注释，生成出来的代码，看上去乱七八糟的。

 <commentGenerator>

\3. 指定链接数据库的账号和密码，既然是逆向工程，肯定要先链接到数据库才对

4．

```java
<jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost/tmall_ssm" userId="root" password="admin">
```

5．指定生成的pojo,mapper, xml文件的存放位置

6． 生成对应表及类名，这里只开放了category表，其他表都注释掉了，下一个知识点再讲，本知识点只讲解category表。

3、在utils包下运行MyBatisGenerator插件，为了防止后续对其他类进行操作修改后，不小心对该插件的再次运行导致被修改的类被覆盖，所以在源码里面修改了需要将时间修改为今天才能使得该插件的正确运行。

4、该插件会根据数据库表格的字段，自动生成pojo、pojo.Example、pojoMapper、pojoMapper.xml，生成的xxx.example，作用是用来排序以及使用条件查询的时候使用，这个类的工作原理不必深究。

5、修改Impl，重写方法

## 十一、属性管理的增删查改实现

### 1、property增加一个Category字段

### 2、新建PropertyService，提供增删查改一套方法，因为业务上需要查询分类下的属性，再增加一个list方法，传入的参数是对应分类的id

### 3、PropertyServiceImpl实现上面的接口，重写方法。使用查询的方法的时候利用逆向工程生成的辅助类Example类进行查询

```java
@Override
    public List list(int cid) {
        PropertyExample example =new PropertyExample();
        example.createCriteria().andCidEqualTo(cid);
       	 	//把查询的结果按id进行排序
        example.setOrderByClause("id desc");
      	 	//查到后返回对象调用传入参数的方法的结果
        return propertyMapper.selectByExample(example);
    }
```

4、修改PropertyController控制器类，用于映射不同路径的访问，对应不同的方法的处理。

5、查询的jsp页面

​      listProperty.jsp页面

//根据传进的id判断是对哪一个商品进行处理，是页面上面得导航

```html
    <ol class="breadcrumb">
      <li><a href="admin_category_list">所有分类</a></li>
      <li><a href="admin_property_list?cid=${c.id}">${c.name}</a></li>
      <li class="active">属性管理</li>
    </ol>
```

 

//属性的名称都保存在一个ps数组里面，一个个遍历出来，每一个对应一个pid，点击的时候带上编辑的地址传到控制器

```html
<c:forEach items="${ps}" var="p">
      <tr>
            <td>${p.id}</td>
            <td>${p.name}</td>
            <td>
            	<a href="admin_property_edit?id=${p.id}">
                        <span class="glyphicon glyphicon-edit"></span>
                 </a>
             </td>
           <td>
               <a deleteLink="true" href="admin_property_delete?id=${p.id}">
                      <span class=" glyphicon glyphicon-trash"></span>
               </a>
            </td>
       </tr>
</c:forEach>
```

6、编辑的jsp页面

editProperty.jsp页面

**//从listProperty.jsp页面获取参数跳转到对应的editProperty.jsp页面，对属性进行编辑修改之后，点击提交按钮，通过action提交到admin_property_update这个方法进行处理

```html

<form method="post" id="editForm" action="admin_property_update">
  <table class="editTable">
     <tr>
      <td>属性名称</td>
      <td>
            <input id="name" name="name" value="${p.name}" type="text" class="form-control">
            </td>               
          </tr>
    <tr class="submitTR">
       <td colspan="2" align="center">
        <input type="hidden" name="id" value="${p.id}">
        <input type="hidden" name="cid" value="${p.category.id}">
        <button type="submit" class="btn btn-success">提 交</button>
             </td>
     </tr>
   </table>
</form>
```

7、增加功能的jsp页面

将表单内容提交到路径admin_property_add，然后通过控制器调用方法

8、修改功能

跳转地址，控制器通过propertyService更新对象到数据库。

9、删除功能

控制器通过delete方法获取id，通过propertyService删除对象的对应数据

## 十二、属性管理的增删查改详解

### 1、查询功能讲解

![Markdown](http://prcfme0aj.bkt.clouddn.com/adminlist.png)

1、  先获取分类的cid

2、  通过分页插件设置分页参数

3、  基于cid，获取当前分类的属性集合

4、  获取属性总数然后设置给分页的page对象

5、  拼接字符串"&cid="+c.getId()，设置给page对象的Param值，访问的时候传递这个cid可以确定是哪个商品的分类

6、  将属性集合设置到request的 "ps" 属性上
 把分类对象设置到 request的 "c" 属性上（面包屑导航显示分类名称）

把分页对象设置到 request的 "page" 对象上

7、  跳转到listProperty.jsp, 使用c:forEach 遍历ps集合，并显示

### 2、增加功能讲解

![Markdown](http://prcfme0aj.bkt.clouddn.com/admin_add.png)

1、在PropertyController通过参数Property 接受注入

2、通过propertyService保存到数据库

3、客户端跳转到admin_property_list,并带上参数cid

### 3、编辑功能讲解

![Markdown](http://prcfme0aj.bkt.clouddn.com/admin_edit.png)

1、先根据id确定Property对象，确定对象之后由cid确定要编辑的属性

2、根据properoty对象的cid属性获取Category对象，并把其设置在Property对象的category属性上（一个产品有多个cid）

3、把Property对象放在request的 "p" 属性中

4、服务端跳转到admin/editProperty.jsp

### 4、修改功能讲解（先点击编辑之后才能修改）

![Markdown](http://prcfme0aj.bkt.clouddn.com/admin_update.png)

### 5、删除功能讲解

![Markdown](http://prcfme0aj.bkt.clouddn.com/admin_del.png)

1. 在PropertyController的delete方法中获取id
   	2. 根据id获取Property对象
      	 	\3. 借助propertyService删除这个对象对应的数据
         	 	\4. 客户端跳转到admin_property_list，并带上参数cid

### 6、总结：增删改都设计到操作数据库，所以都需要使用到propertyService。查询功能则获取对象，遍历集合分页显示。编辑功能不涉及修改，点击编辑功能的链接，根据传入的id，跳转到对应的属性的修改页面

## 十三、产品管理的增删查改

1、pojo包下自动生成的product新增category属性

2、新增ProductService，提供增删查改CRUD一套

３、新增ProductServiceImpl ，提供CRUD一套。 值得一提的是， get和list方法都会把取出来的Product对象设置上对应的category

４、准备ProductController类，映射对应的路径，实现对应功能

## 十四、产品图片的增删查改

## 十五、产品属性值设置



# 前台页面

## 一、注册功能

１、register.jsp 是放在WEB-INF目录下的，是无法通过浏览器直接访问的。 为了访问这些放在WEB-INF下的jsp，准备一个专门的PageController类，专门做服务端跳转。 比如访问registerPage

２、新建一个PageController，单纯作为服务端跳转使用

   ![Markdown](http://prcfme0aj.bkt.clouddn.com/1.png)

３、新建registerPage.jsp ，注册页面的主体功能，用于提交账号密码。 在提交之前会进行为空验证，以及密码是否一致验证。（没有使用到异步）

![Markdown](http://prcfme0aj.bkt.clouddn.com/2.png)

４、UserService新增加isExist(String name)方法代码比较复制代码

５、UserServiceImpl 新增isExist(String name)的实现，判断某个名称是否已经被使用过了。

６、ForeController

![Markdown](http://prcfme0aj.bkt.clouddn.com/3.png)

## 二、登录功能

１、编写login.jsp

２、在UserService中增加get(String name, String password)方法

３、UserServiceImpl中增加User get(String name, String password) 方法重写

４、loginPage.jsp，登陆业务页面，用于向服务器提交账号和密码，通过js函数判断是否为空。

５、如果都不为空，表单绑定地址forelogin，然后将数据提交到controller。

![Markdown](http://prcfme0aj.bkt.clouddn.com/4.png)

## 三、退出功能

点击退出超链接，跳转地址forelogout，提交到控制器，将当前用户从绘画中移除

![Markdown](http://prcfme0aj.bkt.clouddn.com/5.png)

## 四、模块登录功能

![Markdown](http://prcfme0aj.bkt.clouddn.com/6.png)

１、点击购买或者加入购物车就会弹出这个模态对话框

这两个按钮都会通过JQuery的.get方法，用异步ajax的方式访问forecheckLogin，获取当前是否登录状态
 如果返回的不是"success" 即表明是未登录状态，那么就会打开登录的模态窗口

２、立即购买和加入购物车这两个按钮的监听是放在imgAndInfo.jsp页面中

![Markdown](http://prcfme0aj.bkt.clouddn.com/7.png)

３、在ForeController中映射地址，调用方法

![Markdown](http://prcfme0aj.bkt.clouddn.com/8.png)

４、modal.jsp 

modal.jsp 页面被 footer.jsp 所包含，所以每个页面都是加载了的。
​	通过imgAndInfo.jsp页面中的购买按钮或者加入购物车按钮显示出来。
​	点击登录按钮时，使用imgAndInfo.jsp 页面中的ajax代码进行登录验证

５、在ForeController中映射地址，调用loginAjax()方法

![Markdown](http://prcfme0aj.bkt.clouddn.com/9.png)

## 五、分类排序功能

1、页面效果

![Markdown](http://prcfme0aj.bkt.clouddn.com/10.png)

2、准备5个comparator，包括按照销量*评价高的在前面、评价数量多的放在前面、创建日期晚的放在前面、价格低的放在前面。

3、前端控制器准备一个category方法

​       1、先获取参数属性表cid，由cid对应的id作为外键，获取分类表的分类对象c

​       2、填充分类c里面的产品，并填充产品里面的销量与评价数据

​       3、获取参数sort，为空时不进行排序，不为空时从5个选择器中选择一个进行排序

​       4、将对象c放进model中，最后服务端跳转到Category.jsp。

4、准备category.jsp。

![Markdown](http://prcfme0aj.bkt.clouddn.com/11.png)

5、准备categoryPage.jsp

![Markdown](http://prcfme0aj.bkt.clouddn.com/12.png)

6、准备sortBar.jsp（排序条）

​       1、先根据sort参数判断哪个排序按钮高亮

​       2、每个排序按钮点击之后都要提交到本页面/forecategory，然后带上参数sort进行排序

7、准备productsByCategory.jsp，显示当前分类下的所有产品

## 六、搜索功能

1、提供一个搜索的表单，action地址为foreSerach

2、前端控制器映射地址，获取参数keyword，然后根据keyword进行模糊查询，将查询到的结果设置上销量以及评价数量，最后将产品结合设置在model的“ps“属性上，服务端跳转到searchResult页面。

3、修改ProductService，增加search方法

4、修改ProductServiceImpl实现search方法，通过关键字进行模糊查询

![Markdown](http://prcfme0aj.bkt.clouddn.com/13.png)

5、将搜索结果放在searchResult.jsp中

![Markdown](http://prcfme0aj.bkt.clouddn.com/14.png)

6、searchResultPage.jsp 本身没做什么。。。。 直接包含了 productsBySearch.jsp

代码比较复制代码

7、productsBySearch.jsp 显示搜索结果

​         1、遍历ps，把每个产品的图片，价格，标题等信息显示出来
​        	2、如果ps为空，则显示 "没有满足条件的产品"

## 七、立即购买功能

1、为OrderItemService新增方法listByUser，通过用户查找订单

2、OrderItemServiceImpl新增加方法listByUser的实现

3、访问的地址 /forebuyone 导致ForeController.buyone()方法被调用

​	1 获取参数pid
​       		2 获取参数num

​	3 根据pid获取产品对象p
  	   	4 从session中获取用户对象user

4、对forebuyone方法的实现

​       1、通过上一步从session中获取用户、pid、参数、产品对象

​       2、然后新增订单项，有订单项不一定有订单，加入购物车算一个订单项。所以新增订单项需要考虑两个情况

​       A、购物车已经存在这一商品，即已经存在订单项（存在购物车）还没有生成订单，所以需要在原来的基础上调整数量

​              a、基于用户对象user，查询没有生成订单的订单项集合

​              b、遍历这个集合

​              c、如果产品是一样的话，就进行数量追加

​              d、获取这个订单项的 id

​       B、 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem

​              a、生成新的订单项

​              b、设置数量，用户和产品

​              c、插入到数据库

​              d、获取这个订单项的 id

最后， 基于这个订单项id客户端跳转到结算页面/forebuy

![Markdown](http://prcfme0aj.bkt.clouddn.com/15.png)

## 八、结算功能

1、点击立即购买，客户端跳转到购买路径 @forebuy?oiid="+oiid，提交到控制器，导致buy方法被调用。

![Markdown](http://prcfme0aj.bkt.clouddn.com/16.png)

![Markdown](http://prcfme0aj.bkt.clouddn.com/17.png)

2、buy.jsp包含buyPape.jsp，在buyPage中可以遍历出订单项集合ois中的订单项数据，因为是点击立即购买，所以结算的时候只有一件产品，然后显示总金额。

session.setAttribute("ois", ois); 

model.addAttribute("total", total);

a. session 里放的数据可以在其他页面使用 

b. model的数据，只能在接下来的页面使用，其他页面就不能使用了

## 九、加入购物车功能

1、如果未登录，则会弹出模块登录的界面。如果已经登录，那么点击加入购物车之后，使用Ajax异步访问地址foreaddCart，并带上产品的id以及购买的数量。

2、前端控制器映射路径foreaddCart，然后加入购物车需要考虑两种情况

  a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
​               a.1 基于用户对象user，查询没有生成订单的订单项集合
​               a.2 遍历这个集合
​               a.3 如果产品是一样的话，就进行数量追加
​               a.4 获取这个订单项的 id

  b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
​               b.1 生成新的订单项
​               b.2 设置数量，用户和产品
​               b.3 插入到数据库
​               b.4 获取这个订单项的 id

与ForeController.buyone() 客户端跳转到结算页面不同的是， 最后返回字符串"success"，表示添加成功

## 十、查看购物车功能

1、访问地址/forecart导致了前端控制器中cart方法被调用

2、查看购物车的前提必须要登录，才能在session中找到user对象

3、找到user对象之后，获取与这个用户关联的订单项ois

4、然后将ois放进model中，最后服务端跳转到cart.jsp.

5、cart.jsp页面中包含了cartPage.jsp，在cartPage.jsp中遍历订单项集合ois。

## 十一、登录拦截器LoginInterceptor

1、有些界面需要登录才能执行接下来的操作，所以需要准备一个过滤器进行是否登录的判断。如果不通过，就跳转到login.jsp页面

![Markdown](http://prcfme0aj.bkt.clouddn.com/55.png)

2、在SpringMVC.xml中新增对登录状态拦截器的配置

**这个功能同样也可以使用过滤器，用拦截器的好处在于可以方便地获取 Service DAO 这些类，毕竟是和 spring 一套整合在一起的。 过滤器就要自己想办法获取 Service DAO了**

## 十二、其他拦截器OtherInterceptor

1、![Markdown](http://prcfme0aj.bkt.clouddn.com/18.png)

2、![Markdown](http://prcfme0aj.bkt.clouddn.com/19.png)

3、![Markdown](http://prcfme0aj.bkt.clouddn.com/20.png)

4、在SpringMVC.xml中配置拦截器

## 十三、购物车页面的操作

### 1、调整产品的数量

如果点击了增加或者减少的按钮之后，会根据 cartPage.jsp 中的js代码，通过Ajax访问/forechangeOrderItem路径，导致ForeController.changeOrderItem()方法被调用

1.判断用户是否登录，如果没有登录则跳转到登录界面

2.获取pid和number

3.遍历出用户当前所有的未生成订单的OrderItem

4.根据pid找到匹配的OrderItem，并修改数量后更新到数据库

5.返回字符串"success"

![Markdown](http://prcfme0aj.bkt.clouddn.com/21.png)

### 2、删除订单项

点击删除按钮，会根据 cartPage.jsp 中的js代码，过Ajax访问/foredeleteOrderItem路径，导致ForeController.deleteOrderItem方法被调用

1、判断用户是否登录

2、获取oiid

3、删除oiid对应的OrderItem数据

4、返回字符串"success"

![Markdown](http://prcfme0aj.bkt.clouddn.com/22.png)

### 3、提交到结算界面

选中任意商品之后，结算按钮呈现可以点击的状态，将选中的OrderItem的id提交到结算页面

## 十四、生成订单的操作

### 1、在applicationContext.xml中增加对事务管理的配置。因为在增加Order表的同时需要及时更新修改OrderItem表，如果此时突然断电那么OrderItem的数据就会变成脏数据，没有指向正确的Order表。

![Markdown](http://prcfme0aj.bkt.clouddn.com/23.png)

### 2、在OrderService中新增一个add方法

​             float add(Order c,List<OrderItem> ois);

### 3、OrderServiceImpl实现上面的方法，通过注解进行事务的管理。

![Markdown](http://prcfme0aj.bkt.clouddn.com/24.png)

### 4、提交订单访问路径 /forecreateOrder, 导致ForeController.createOrder 方法被调用

a、从session中获取user对象

b、通过参数Order接受地址，邮编，收货人，用户留言等信息

c、根据当前时间加上一个4位随机数生成订单号

d、把订单状态设置为等待支付

e、从session中获取订单项集合 ( 在结算功能的ForeController.buy() 13行，订单项集合被放到了session中 )

f、把订单加入到数据库，并且遍历订单项集合，设置每个订单项的order，更新到数据库

g、统计本次订单的总金额

h、客户端跳转到确认支付页forealipay，并带上订单id和总金额

### 5、确认支付页面

在上一步执行后会重定向到forealipay方法，然后导致PageController中的alipay()方法被调用，而alipay方法只是将服务端跳转到alipay.jsp页面，alipay.jsp中包含其他的公共页面以及包含了alipayPage.jsp的确认支付页面，显示了总金额，并且点击确认支付按钮跳转到页面/forepayed页面，并带上了oid和金额

### 6、支付成功页面

1. #### 在上一步确认访问按钮提交数据到/forepayed,导致ForeController.payed方法被调用   

   ​      1.1 获取参数oid
   ​               1.2 根据oid获取到订单对象order
   ​               1.3 修改订单对象的状态和支付时间
   ​               1.4 更新这个订单对象到数据库
   ​               1.5 把这个订单对象放在model的属性"o"上
   ​               1.6 服务端跳转到payed.jsp

   ![Markdown](http://prcfme0aj.bkt.clouddn.com/25.png)

####       2、 payed.jsp，包含了其他的公共页面，其中也包含了payedPage.jsp，显示订单中的地址、邮政编码、收货人、手机号码等等

## 十五、查看我的订单页面

### 1、修改OrderService，新增List list(int uid, String excludedStatus)方法（订单一共有6种状态，待付款、待发货、待确认、待评价、确认收货完成状态还有删除（但是订单是一个很重要的数据，删除只是表面显示已删除））

### 2、修改OrderServiceImpl，实现方法

![Markdown](http://prcfme0aj.bkt.clouddn.com/26.png)

### 3、点击我的订单，映射地址/forebought导致了ForeController.bought()方法被调用

a、通过session获取用户user

b、查询user所有的状态不是"delete" 的订单集合os

c、为这些订单填充订单项

d、把os放在model的属性"os"上

e、服务端跳转到bought.jsp

### 4、然后bought.jsp中包含其他公共页面和boughtPage.jsp，然后在bought.jsp中

a、 遍历订单集合os
​        取出每个订单，显示其创建日期，订单号，总数量和总金额等

b、遍历每个订单下的订单项集合o.orderItemsd 
​        显示每个订单项对应的产品的图片，标题，原始价格，优惠价格等

## 十六、我的订单页面操作

![Markdown](http://prcfme0aj.bkt.clouddn.com/27.png)

### 1、点击付款按钮直接跳到生成订单的确认支付的页面。

### 2、点击确认收货，访问地址/foreconfirmPay，使得前端控制器中的confirmPay()方法被调用

2.1 获取参数oid
​       2.2 通过oid获取订单对象o
​       2.3 为订单对象填充订单项
​       2.4 把订单对象放在request的属性"o"上
​       2.5 服务端跳转到 confirmPay.jsp

![Markdown](http://prcfme0aj.bkt.clouddn.com/28.png)

### 3、confirmPay.jsp中包含有confirmPayPage.jsp

显示订单的创建时间，付款时间和发货时间，以及订单号，收款人信息等
 遍历订单项集合，显示其中的产品图片，产品标题，价格，数量，小计，总结信息，然后提供一个确认收货的按钮

### 4、确认收货成功。点击确认收货的按钮，提交到/foreorderConfirmed路径，导致orderConfirmed()方法被调用

a、ForeController.orderConfirmed()方法
​                     1.1 获取参数oid
​                     1.2 根据参数oid获取Order对象o
​                     1.3 修改对象o的状态为等待评价，修改其确认支付时间
​                     1.4 更新到数据库
​                     1.5 服务端跳转到orderConfirmed.jsp页面

b、 orderConfirmed.jsp              

与 register.jsp 相仿，orderConfirmed.jsp也包含了header.jsp](http://how2j.cn/k/tmall_ssm/tmall_ssm-1490/1490.html#step6219), top.jsp, simpleSearch.jsp， footer.jsp 等公共页面中间是确认收货成功业务页面 orderConfirmedPage.jsp

### 5、orderConfirmed.jsp中包含了orderConfirmPage.jsp，在orderConfirmPage.jsp中显示"交易已经成功，卖家将收到您的货款

### 6、删除订单操作

在我的订单页 上点击删除按钮，根据 boughtPage.jsp 中的ajax操作，会访问路径/foredeleteOrder，导致ForeController.deleteOrder方法被调用

a、ForeController.deleteOrder()

​      1.1 获取参数oid
​             1.2 根据oid获取订单对象o
​             1.3 修改状态
​             1.4 更新到数据库
​             1.5 返回字符串"success"

b、boughtPage.jsp 中的javascript代码获取返回字符串是success的时候，隐藏掉当前这行订单数据。

![Markdown](http://prcfme0aj.bkt.clouddn.com/29.png)

![Markdown](http://prcfme0aj.bkt.clouddn.com/30.png)

## 十七、评价产品

### 1、点击评价按钮，对应/forereview，调用前端控制器中review()方法

1. ### ForeController.review()

   ​          1.1 获取参数oid
   ​                 1.2 根据oid获取订单对象o
   ​                 1.3 为订单对象填充订单项
   ​                 1.4 获取第一个订单项对应的产品,因为在评价页面需要显示一个产品图片，那么就使用这第一个产品的图片了
   ​                  1.5 获取这个产品的评价集合
   ​                  1.6 为产品设置评价数量和销量
   ​                  1.7 把产品，订单和评价集合放在request上
   ​                  1.8 服务端跳转到 review.jsp

![Markdown](http://prcfme0aj.bkt.clouddn.com/31.png)

### 2.review.js

与 register.jsp 相仿，review.jsp也包含了header.jsp, top.jsp, simpleSearch.jsp， 
footer.jsp 等公共页面。

中间是产品业务页面 reviewPage.jsp

### 3.reviewPage.jsp

在reviewPage.jsp中显示产品图片，产品标题，价格，产品销量，产品评价数量，   以及订单信息等。 
同时还显示出了该产品所有的评价，但是默认是隐藏的

### 4、提交评价

在评价产品页面点击提交评价，就把数据提交到了/foredoreview路径，导致ForeController.doreview方法被调用

a、

​      1.1 获取参数oid
​              1.2 根据oid获取订单对象o
​              1.3 修改订单对象状态
​              1.4 更新订单对象到数据库
​              1.5 获取参数pid
​              1.6 根据pid获取产品对象
​              1.7 获取参数content (评价信息)
​              1.8 对评价信息进行转义（防止评价信息里面写脚本然后出现弹窗的情况），道理   同注册ForeController.register()
​              1.9 从session中获取当前用户
​              1.10 创建评价对象review
​              1.11 为评价对象review设置 评价信息，产品，时间，用户
​              1.12 增加到数据库
​              1.13.客户端跳转到/forereview： 评价产品页面，并带上参数showonly=true
![Markdown](http://prcfme0aj.bkt.clouddn.com/32.png)

b、 reviewPage.jsp
​               在reviewPage.jsp中，当参数showonly==true，那么就显示当前产品的所有评价信息

## 十八、部署项目到阿里云服务器

  使用Xshell和Xftp，安装完成后，先打开Xshell，远程连接到服务器的公网ip地址，然后点击新建文件传输安装按钮，安装jdk,tomcat,mysql等环境，然后还需要配置防火墙和开放阿里云的端口，主要是8080和3306端口链接数据库，上传war包的时候记得先关闭tomcat。本项目的数据库密码是1234，用户root。数据库名tmall_ssm，最后记得要将数据上传到数据库，之前就忘了这一步一直访问不到，我自己可真是个哈皮。sql文件暂时放在项目根目录了。
