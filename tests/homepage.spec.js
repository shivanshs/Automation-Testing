import { test, expect } from '@playwright/test';

test('Verify Contact form and Book now buttons are present on all listed rooms', async ({ page }) => {
  //Step 1: Navigate to home page
  await page.goto('https://automationintesting.online');

  //Step 2: Verify the presence of the contact form and its fields
  await expect(page.getByText('NameEmailPhoneSubjectMessageSubmit')).toBeVisible();
  await expect(page.getByRole('heading', { name: 'Send Us a Message' })).toBeVisible();
  await expect(page.getByText('Name')).toBeVisible();
  await expect(page.getByTestId('ContactName')).toBeVisible();
  await expect(page.locator('#contact').getByText('Email')).toBeVisible();
  await expect(page.getByTestId('ContactEmail')).toBeVisible();
  await expect(page.locator('#contact').getByText('Phone')).toBeVisible();
  await expect(page.getByTestId('ContactPhone')).toBeVisible();
  await expect(page.getByText('Subject')).toBeVisible();
  await expect(page.getByTestId('ContactSubject')).toBeVisible();
  await expect(page.getByText('Message', { exact: true })).toBeVisible();
  await expect(page.getByTestId('ContactDescription')).toBeVisible();
  await expect(page.getByRole('button', { name: 'Submit' })).toBeVisible();

  //Step 3: Verify the presence of the "Book now" button on all listed rooms
  const roomCards = page.locator('.room-card');
  await expect(roomCards.first()).toBeVisible();
  const roomCount = await roomCards.count();

  expect(roomCount).toBeGreaterThan(0);

  for (let i = 0; i < roomCount; i++) {
    await expect(roomCards.nth(i).getByRole('link', { name: 'Book now' })).toBeVisible();
  }
});