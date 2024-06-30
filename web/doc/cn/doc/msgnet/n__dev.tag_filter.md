节点：标签读取过滤器
==

此节点对输入的消息不做任何处理，输入消息仅仅是一个触发运行的作用


在项目数据组织中，所有的标签(Tags)都在一颗项目树中。如果我们要提取利用里面的部分数据，最简单的是以这棵树为基础，使用过滤的方式获取一颗子树，并发送到数据使用端。这也是IOT-Tree应用的典型场景。




### 参数设置

双击可以打开节点参数设置对话框

#### 根路径


选择输入项目组织中的一个容器节点，那么此节点就限定在这个节点以下的容器节点和标签数据内容。



#### 包含系统标签


勾选此项，会把子树下面的系统标签也一起输出



#### 容器节点

以容器节点类型进行过滤条件，启用此过滤时，你可以勾选满足输出条件的容器类型



#### 容器节点属性

以容器节点属性作为过滤条件，启用此过滤时，你可以勾选满足输出条件的容器属性。这些属性在项目管理中通过字典对容器节点做相关的设置而存在。



#### 标签属性

以标签属性作为过滤条件，启用此过滤时，你可以勾选满足输出条件的容器属性。这些属性在项目管理中通过字典对标签做相关的设置而存在。

