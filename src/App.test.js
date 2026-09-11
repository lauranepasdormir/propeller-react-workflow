import { render, screen } from '@testing-library/react';
import App from './App';

test('renders DirtMate link', () => {
  render(<App />);
  const linkElement = screen.getByText(/explore dirtmate/i);
  expect(linkElement).toHaveAttribute('href', 'https://www.propelleraero.com/dirtmate/');
});
