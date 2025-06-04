# 开发指南

## 快速开始

### 自动设置（推荐）

**Windows 用户：**
```bash
# 使用 PowerShell（推荐）
.\setup.ps1

# 或使用批处理文件
.\setup.bat
```

### 手动设置

1. **安装后端依赖**
```bash
cd fastapi-backend
uv sync
uv run prisma generate
```

2. **安装前端依赖**
```bash
cd nextjs-frontend
yarn install
```

## 开发环境启动

### 方式一：使用 Docker Compose（推荐）

```bash
# 启动所有服务（数据库、后端、前端）
make dev-docker

# 或者
docker compose up
```

### 方式二：分别启动服务

1. **启动数据库**
```bash
make db-up
# 或者
docker compose up db -d
```

2. **启动后端**
```bash
make start-backend
# 或者
cd fastapi-backend && uv run uvicorn app.main:app --reload
```

3. **启动前端**（新终端窗口）
```bash
make start-frontend
# 或者
cd nextjs-frontend && yarn dev
```

## 访问地址

- **前端应用**: http://localhost:3000
- **后端 API**: http://localhost:8000
- **API 文档**: http://localhost:8000/docs
- **ReDoc 文档**: http://localhost:8000/redoc

## 数据库操作

### Prisma 命令

```bash
cd fastapi-backend

# 生成 Prisma 客户端
uv run prisma generate

# 创建迁移
uv run prisma migrate dev --name "描述"

# 重置数据库
uv run prisma migrate reset

# 查看数据库
uv run prisma studio
```

### 数据库管理

```bash
# 启动数据库
make db-up

# 停止数据库
make db-down

# 重置数据库
make db-reset
```

## 测试

### 后端测试

```bash
make test-backend
# 或者
cd fastapi-backend && uv run pytest
```

### 前端测试

```bash
make test-frontend
# 或者
cd nextjs-frontend && yarn test
```

## 代码质量

### 后端代码检查

```bash
cd fastapi-backend

# 代码格式化
uv run ruff format .

# 代码检查
uv run ruff check .

# 类型检查
uv run mypy .
```

### 前端代码检查

```bash
cd nextjs-frontend

# ESLint 检查
yarn lint

# TypeScript 类型检查
yarn type-check
```

## API 客户端生成

前端会自动从后端的 OpenAPI 规范生成类型安全的 API 客户端：

```bash
cd nextjs-frontend
yarn generate-client
```

## Docker 命令

```bash
# 构建所有镜像
make docker-build

# 启动所有服务
make docker-up

# 停止所有服务
make docker-down

# 查看日志
make docker-logs

# 进入容器
make docker-backend-shell
make docker-frontend-shell
```

## 环境变量

### 后端环境变量

复制 `fastapi-backend/env.example` 到 `fastapi-backend/.env` 并根据需要修改：

```bash
cp fastapi-backend/env.example fastapi-backend/.env
```

### 前端环境变量

复制 `nextjs-frontend/env.example` 到 `nextjs-frontend/.env.local` 并根据需要修改：

```bash
cp nextjs-frontend/env.example nextjs-frontend/.env.local
```

## 项目结构

```
├── fastapi-backend/          # FastAPI 后端
│   ├── app/                  # 应用核心代码
│   │   ├── routers/         # API 路由
│   │   ├── models/          # 数据模型
│   │   ├── schemas/         # Pydantic 模式
│   │   ├── services/        # 业务逻辑
│   │   └── utils/           # 工具函数
│   ├── prisma/              # Prisma 数据库模式
│   ├── tests/               # 测试文件
│   └── pyproject.toml       # Python 项目配置
├── nextjs-frontend/         # Next.js 前端
│   ├── app/                 # Next.js App Router
│   ├── components/          # React 组件
│   │   └── ui/             # shadcn/ui 组件
│   ├── lib/                 # 工具函数和 API 客户端
│   └── __tests__/          # 测试文件
├── local-shared-data/       # 本地共享数据
├── docker-compose.yml       # Docker 编排配置
└── Makefile                # 快捷命令
```

## 常见问题

### 1. 数据库连接失败

确保 PostgreSQL 数据库正在运行：
```bash
make db-up
```

### 2. Prisma 客户端未生成

重新生成 Prisma 客户端：
```bash
cd fastapi-backend
uv run prisma generate
```

### 3. 前端依赖安装失败

清除缓存并重新安装：
```bash
cd nextjs-frontend
rm -rf node_modules yarn.lock
yarn install
```

### 4. 端口冲突

检查端口占用并修改配置：
- 前端：3000
- 后端：8000
- 数据库：5432

## 部署

项目支持部署到 Vercel。详细部署说明请参考各自目录下的 README 文件。

## 贡献

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request 