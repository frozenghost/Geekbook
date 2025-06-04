import { render, screen } from '@testing-library/react'
import Home from '@/app/page'

describe('Home', () => {
  it('renders the main heading', () => {
    render(<Home />)
    
    const heading = screen.getByRole('heading', {
      name: /next\.js fastapi template/i,
    })
    
    expect(heading).toBeInTheDocument()
  })
  
  it('renders the description', () => {
    render(<Home />)
    
    const description = screen.getByText(/一个现代化的全栈开发模板/i)
    
    expect(description).toBeInTheDocument()
  })
}) 