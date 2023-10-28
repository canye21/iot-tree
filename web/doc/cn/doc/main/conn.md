IOT-Tree接入(Connector)
==


IOT-Tree Server接入是每个项目实现的数据来源起点。不管你的数据来源是现场设备还是其他计算机系统，都需要先配置对应的接入。

# 1 接入支持

IOT-Tree Server数据来源接入支持很多种内容，并且随着后续的不断完善，可以提供更多的支持。当前支持的接入主要有串口(COM)、Tcp Client、Tcp Server、OPC DA、OPC UA、MQTT、HTTP URL等

# 2 接入的三种主要分类

IOT-Tree Server对各种接入做了抽象，并形成三个基本的分类，链接(Link)、绑定(Binder)和消息(Message)。他们分别对应我们在获取数据时的最主要的三种方式。

## 2.1 链接link

链接方式主要针对接入源需要和IOT-Tree Server建立一个持久的双向通道，并且在通道上面交互的数据需要相关的驱动来支持。

如计算机串口(COM),Tcp链接，在数据源和IOT-Tree Server会建立一个相对稳定的长链路。然后，根据数据源能够支持的情况，在IOT-Tree Server内部使用对应的驱动协议进行。如Modbus协议，或者是你的私有协议。

这个驱动一般配置在与链接关联的Channel上，具体请参考 [接入(Connector)-通道(Channel)-驱动(Driver) ][conn_ch_drv]。

目前，传统的工业现场设备，通过总线、以太网方式接入到IOT-Tree Server一般都使用此方式来进行接入。

更多内容，请参考如下内容：


## 2.2 绑定(Binder)

一些数据来源可以直接提供结构化的数据，并且每个数据不仅有唯一标识（或路径），并且还携带值数据类型等内容，并且此结构相对固定。此时，接入的数据可以直接通过绑定的方式与关联通道下面的数据结构定义进行绑定（建立对应关系）。

此方式一般支持OPC DA、OPC UA等标准接口。OPC DA、OPC UA一般可以由工业现场的监控计算机的组态软件、或者是设备支持专门软件(如西门子s7-200对应的软件PC Access,通用的商业软件KepServer)支持。一些高端的PLC也可以直接支持OPC标准接口，如西门子s7-1200可以直接支持OPC UA。

## 2.3 消息(Message)

如果数据来源每次过来的都是一个可以独立处理的内容，则被抽象成消息来源方式。消息来源方式根据消息的特点可以支持两种处理方法。

一种是消息格式比较固定，如固定的json或xml格式，则我们可能需要提取里面固定位置的数据。此时，处理方式可以先通过路径（如jsonpath、xpath）方式定位里面的具体数据，然后通过绑定方式与关联通道下面的数据建立对应关系。

另一种消息格式是消息格式复杂不固定或需要做定制化的处理，此时IOT-Tree提供了js脚本方式的处理支持，此方式最为灵活，不仅可以提取数据设置到关联通道下面的具体数据，还可以支持新设备的发现等特殊支持。

更多内容，请参考如下内容：


# 3 接入数据之后处理

接入部分在IOT-Tree Server作为入口而存在，不建议做太多数据处理。其中，消息通过三种

[conn_ch_drv]: ./quick_know_ch_conn_drv.md