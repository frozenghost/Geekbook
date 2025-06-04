# Next.js FastAPI Template

一个现代化的全栈开发模板，集成了 Next.js 前端和 FastAPI 后端，提供完整的类型安全和开发体验。

## 技术栈

### 后端 (FastAPI)
- **FastAPI** - 现代、快速的 Python Web 框架
- **Prisma** - 现代化的 ORM，替代 SQLAlchemy
- **UV** - Python 包管理和虚拟环境管理
- **Pydantic** - 数据验证和序列化
- **PostgreSQL** - 数据库

### 前端 (Next.js)
- **Next.js 15** - React 全栈框架
- **TypeScript** - 类型安全的 JavaScript
- **Tailwind CSS** - 实用优先的 CSS 框架
- **shadcn/ui** - 现代化的 React 组件库
- **Zod** - TypeScript 优先的模式验证
- **Yarn** - 包管理器

## 项目结构

```
├── fastapi-backend/          # FastAPI 后端
│   ├── app/                  # 应用核心代码
│   ├── prisma/              # Prisma 数据库模式和迁移
│   ├── tests/               # 测试文件
│   └── pyproject.toml       # Python 项目配置
├── nextjs-frontend/         # Next.js 前端
│   ├── app/                 # Next.js App Router
│   ├── components/          # React 组件
│   ├── lib/                 # 工具函数
│   └── package.json         # Node.js 项目配置
├── local-shared-data/       # 本地共享数据
├── docker-compose.yml       # Docker 编排配置
└── Makefile                # 快捷命令
```

## 快速开始

### 环境要求
- Python 3.10+
- Node.js 18+
- Yarn
- Docker & Docker Compose

### 安装依赖

1. **后端依赖**
```bash
cd fastapi-backend
uv sync
```

2. **前端依赖**
```bash
cd nextjs-frontend
yarn install
```

### 启动开发环境

#### 使用 Docker Compose (推荐)
```bash
# 启动所有服务
docker compose up

# 或者分别启动
make docker-start-backend
make docker-start-frontend
```

#### 本地开发
```bash
# 启动后端
make start-backend

# 启动前端 (新终端)
make start-frontend
```

### 访问应用
- 前端: http://localhost:3000
- 后端 API: http://localhost:8000
- API 文档: http://localhost:8000/docs

## 可用命令

查看所有可用命令：
```bash
make help
```

### 后端命令
- `make start-backend` - 启动后端开发服务器
- `make test-backend` - 运行后端测试
- `make migrate-db` - 运行数据库迁移

### 前端命令
- `make start-frontend` - 启动前端开发服务器
- `make test-frontend` - 运行前端测试
- `make build-frontend` - 构建前端生产版本

### Docker 命令
- `make docker-build` - 构建所有 Docker 镜像
- `make docker-up` - 启动所有服务
- `make docker-down` - 停止所有服务

## 开发指南

### 数据库操作
```bash
# 生成 Prisma 客户端
cd fastapi-backend
uv run prisma generate

# 创建迁移
uv run prisma migrate dev --name init

# 重置数据库
uv run prisma migrate reset
```

### API 客户端生成
前端会自动从后端的 OpenAPI 规范生成类型安全的 API 客户端。

## 部署

项目支持部署到 Vercel：
- 后端: 无服务器函数
- 前端: 静态站点生成

详细部署说明请参考各自目录下的 README 文件。

## 许可证

MIT License 