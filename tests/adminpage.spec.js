import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  // Step 1: Login via the admin portal
  await page.goto('https://automationintesting.online/');
  await page.getByRole('link', { name: 'Admin', exact: true }).click();
  await expect(page.getByText('Username')).toBeVisible();
  await page.getByRole('textbox', { name: 'Username' }).fill('admin');
  await expect(page.getByText('Password')).toBeVisible();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  await page.getByRole('button', { name: 'Login' }).click();

  // Step 2: Verify that the user is redirected to the dashboard View
  await expect(page).toHaveURL(/rooms/);
  await expect(page.getByText('Room #')).toBeVisible();

  //Step 3: Verify the presence of Logout button
  await expect(page.getByRole('button', { name: 'Logout' })).toBeVisible();
});