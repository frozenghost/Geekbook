import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

export default function Home() {
  return (
    <main className="container mx-auto px-4 py-8">
      <div className="flex flex-col items-center justify-center min-h-[80vh] space-y-8">
        <div className="text-center space-y-4">
          <h1 className="text-4xl font-bold tracking-tight">
            Next.js FastAPI Template
          </h1>
          <p className="text-xl text-muted-foreground max-w-2xl">
            一个现代化的全栈开发模板，集成了 Next.js 前端和 FastAPI 后端，提供完整的类型安全和开发体验。
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 w-full max-w-4xl">
          <Card>
            <CardHeader>
              <CardTitle>FastAPI 后端</CardTitle>
              <CardDescription>
                现代、快速的 Python Web 框架
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="text-sm space-y-1">
                <li>• Prisma ORM</li>
                <li>• UV 包管理</li>
                <li>• Pydantic 验证</li>
                <li>• PostgreSQL 数据库</li>
              </ul>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Next.js 前端</CardTitle>
              <CardDescription>
                React 全栈框架
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="text-sm space-y-1">
                <li>• TypeScript</li>
                <li>• Tailwind CSS</li>
                <li>• shadcn/ui 组件</li>
                <li>• Zod 验证</li>
              </ul>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>开发工具</CardTitle>
              <CardDescription>
                现代化的开发体验
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="text-sm space-y-1">
                <li>• Docker Compose</li>
                <li>• 热重载</li>
                <li>• 类型安全</li>
                <li>• API 自动生成</li>
              </ul>
            </CardContent>
          </Card>
        </div>

        <div className="flex gap-4">
          <Button asChild>
            <a href="http://localhost:8000/docs" target="_blank" rel="noopener noreferrer">
              查看 API 文档
            </a>
          </Button>
          <Button variant="outline" asChild>
            <a href="https://github.com/vintasoftware/nextjs-fastapi-template" target="_blank" rel="noopener noreferrer">
              GitHub 仓库
            </a>
          </Button>
        </div>
      </div>
    </main>
  )
} 