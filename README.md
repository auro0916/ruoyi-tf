# RuoYi Terraform on AWS

使用 **Terraform** 在 **AWS** 上部署 RuoYi 项目的基础设施。

本项目主要用于实践完整的 AWS 基础设施构建流程，包括网络、数据库、缓存、容器服务、负载均衡、前端托管、监控以及 HTTPS 等内容。

## 项目进度

| 模块 | 状态 |
|---|---|
| Terraform 网络环境 | ✅ 已完成 |
| Security Groups 安全组 | ✅ 已完成 |
| Bastion EC2 跳板机 | ✅ 已完成 |
| RDS MySQL 数据库 | ✅ 已完成 |
| ElastiCache 缓存 | ✅ 已完成 |
| Amazon ECR 镜像仓库 | ✅ 已完成 |
| ECS / Fargate 后端服务 | ✅ 已完成 |
| Application Load Balancer | ✅ 已完成 |
| S3 / CloudFront 前端部署 | ✅ 已完成 |
| CloudWatch 监控 | ✅ 已完成 |
| HTTPS / 自定义域名 | ⏳ 进行中 |

## 使用的 AWS 服务

本项目目前主要使用以下 AWS 服务：

- Amazon VPC
- Public Subnet / Private Subnet
- Internet Gateway
- NAT Gateway
- Amazon EC2
- Amazon RDS for MySQL
- Amazon ElastiCache
- Amazon ECR
- Amazon ECS
- AWS Fargate
- Application Load Balancer
- Amazon S3
- Amazon CloudFront
- Amazon CloudWatch
- AWS Certificate Manager
- Amazon Route 53

## 项目目标

本项目的目标是通过 Terraform，从 0 开始构建一套完整的 RuoYi AWS 运行环境。

相比直接在 AWS Management Console 中手动创建资源，本项目尽量通过 Infrastructure as Code 的方式管理基础设施，使环境具备：

- 可重复创建
- 可统一管理
- 可版本控制
- 可快速重建
- 可持续优化

## 整体架构

```text
                        Internet
                           |
                    +-------------+
                    | CloudFront  |
                    +-------------+
                           |
                        S3 Frontend


                        Internet
                           |
                    +-------------+
                    |     ALB     |
                    +-------------+
                           |
                    +-------------+
                    | ECS/Fargate |
                    +-------------+
                      |         |
              +-------+         +-------+
              |                         |
         +---------+               +-------------+
         |   RDS   |               | ElastiCache |
         |  MySQL  |               |    Cache    |
         +---------+               +-------------+
```

## 网络架构

AWS 网络环境基于 VPC 构建，并划分不同类型的子网：

```text
VPC
|
|-- Public Subnet
|     |
|     |-- Application Load Balancer
|     |-- Bastion EC2
|     |-- NAT Gateway
|
|-- Private App Subnet
|     |
|     |-- ECS / Fargate
|     |-- ElastiCache
|
|-- Private DB Subnet
      |
      |-- Amazon RDS
```

Public Subnet 通过 Internet Gateway 访问互联网。

Private App Subnet 通过 NAT Gateway 进行互联网出站访问。

Private DB Subnet 不直接访问公网，主要用于部署数据库资源。

## 后端部署

RuoYi 后端通过 Docker 构建镜像，并上传至 Amazon ECR。

之后由 ECS + Fargate 运行后端容器。

整体流程：

```text
RuoYi Backend
      |
      v
Docker Build
      |
      v
Amazon ECR
      |
      v
ECS / Fargate
      |
      v
Application Load Balancer
```

## 前端部署

前端项目构建完成后，将静态文件部署到 Amazon S3。

通过 CloudFront 提供 CDN 和公网访问能力。

```text
Frontend Build
      |
      v
Amazon S3
      |
      v
Amazon CloudFront
      |
      v
User
```

## 数据库

数据库使用：

```text
Amazon RDS for MySQL
```

数据库部署在 Private DB Subnet 中，不直接暴露到公网。

应用通过 Security Group 控制访问权限，仅允许指定的 ECS / EC2 资源访问数据库。

## 缓存

项目使用 Amazon ElastiCache 提供缓存服务。

缓存服务部署在 Private App Subnet 中，仅允许应用层访问。

## Terraform

基础设施主要通过 Terraform 进行管理。

常用命令：

```bash
terraform init
```

初始化 Terraform 环境。

```bash
terraform fmt
```

格式化 Terraform 配置。

```bash
terraform validate
```

检查 Terraform 配置是否合法。

```bash
terraform plan
```

查看即将创建或修改的 AWS 资源。

```bash
terraform apply
```

创建或更新 AWS 基础设施。

```bash
terraform destroy
```

销毁 Terraform 管理的 AWS 资源。

## CI/CD

项目已经加入 CI/CD 流程。

目前主要流程包括：

```text
Git Push / Tag
      |
      v
GitHub Actions
      |
      +--------------------+
      |                    |
      v                    v
     CI                   CD
      |                    |
Build / Test          Docker Build
                           |
                           v
                         ECR
                           |
                           v
                     ECS Deployment
```

CI 主要负责：

- 代码检查
- 项目构建
- 构建验证

CD 主要负责：

- 构建 Docker Image
- Push 镜像到 Amazon ECR
- 更新 ECS Task Definition
- 部署新的 ECS Service

## 当前状态

目前 RuoYi 在 AWS 上运行所需要的主要基础设施已经基本完成。

已完成：

- VPC 网络设计
- Public / Private Subnet
- Internet Gateway
- NAT Gateway
- Security Groups
- Bastion EC2
- RDS MySQL
- ElastiCache
- Amazon ECR
- ECS / Fargate
- Application Load Balancer
- S3
- CloudFront
- CloudWatch
- CI/CD

正在完善：

- HTTPS
- 自定义域名
- Terraform 代码优化
- Terraform Module 拆分
- 安全策略优化
- CI/CD 流程优化
- 日志与监控优化

## 项目用途

本仓库主要用于学习和实践以下内容：

- AWS 云基础设施
- Terraform
- Infrastructure as Code
- VPC 网络设计
- Docker
- Amazon ECS
- AWS Fargate
- Amazon RDS
- Amazon ElastiCache
- Amazon ECR
- Application Load Balancer
- Amazon S3
- Amazon CloudFront
- Amazon CloudWatch
- GitHub Actions
- CI/CD
- DevOps

## 项目说明

本项目主要用于个人 AWS / Terraform / DevOps 学习与实践。

重点并不是开发 RuoYi 的业务功能，而是通过一个真实的应用项目，完整实践：

```text
代码
 ↓
Docker
 ↓
CI/CD
 ↓
Terraform
 ↓
AWS Infrastructure
 ↓
ECS Deployment
 ↓
Monitoring
```

最终目标是掌握一个应用从本地代码到 AWS 云环境完整部署的过程。
