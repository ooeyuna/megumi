# Megumi

## Description

configuration center


## Install


## Stucture

```bash

config # 挂载的目录
├── prod # 环境env
│   ├── all.yml
│   └── shizuku.yml # shizuku系统的额外配置,如果与all有重合则会覆盖all的配置
└── staging
    ├── all.yml
    └── shizuku.yml
    
```

## API

- 获取资源:

    Request:

    GET `/{env}/{service}`

    ```json
    {
      "service" : "shizuku", //系统
      "resources": [ //所需的资源
        "redis",
        "mysql",
        "zookeeper",
        "marathon",
        "mesos",
        "api_gateway"
      ]
    }
    ```

    Response:

    ```json
    {
      "resources": {
        "redis": {
          "url": "meiling.siyu.im",
          "port": 6379
        },
        "mysql":{
          "url": "meiling.siyu.im",
          "port": 3306,
          "user": "madedalei",
          "password": "madedalei"
        },
        "zookeeper": {
          ...
        },
        "marathon":{
          ...
        },
        "mesos":{
          ...
        },
        "api_gateway":{
          ...
        }
      }
    }
    ```

- 立即刷新配置(读取文件)

  Request:
    
    POST `/refresh`

## TODO

1. 现在是文件+内存(只读)的形式存配置数据,以后可以考虑用etcd来做存储,尽可能避免挂载文件系统(进marathon)

2. 支持node的CRUD,比较繁琐,最好能交给存储(etcd)来解决这个事情

3. node的TTL处理,需求同上

4. 长连接watch key的变化, websocket主动推送信息

5. 服务主动维持TTL,服务发现,健康检查

    - 不过现在更倾向于把服务发现交给api gateway系统,应用在启动后将广播地址,服务名,匹配地址,发给网关系统

    - 服务健康检查交给marathon等第三方系统来做,但也有个考虑就是健康检查可能会需要触发一些报警措施,这里marathon是无法自定义的,为了这个监听marathon的event又有点画蛇添足.让网关承载这个任务可能会合适点,但网关自身性能要求很高,不适合做这个事

make change2
