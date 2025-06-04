import { defineConfig } from '@hey-api/openapi-ts'

export default defineConfig({
  client: '@hey-api/client-fetch',
  input: './shared-data/openapi.json',
  output: {
    format: 'prettier',
    path: './lib/generated',
  },
}) 