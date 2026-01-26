# EmployMe (Hackathon Submission)

![Next.js](https://img.shields.io/badge/Next.js-14-black) ![TypeScript](https://img.shields.io/badge/TypeScript-Strict-blue) ![Supabase](https://img.shields.io/badge/Supabase-Database-green)

**A dual-pane resume editor built with Next.js and Supabase.**

> **Context:** This project was built during a 48 hour hackathon. It is a functional prototype designed to solve the pain of managing multiple resume versions. This branch highlights my individual contribution of the resume editor/management system.

## Why I Built This
I got tired of maintaining 5 different Word documents for different job applications. I wanted a "Source of Truth" (Master Resume) that I could branch off into specific versions without copy-pasting formatting around.

The idea is **Write in JSON/Form, render in PDF.**

## The Stack
* **Next.js 14 (App Router):** For layout handling and server actions.
* **Supabase:** Auth & Database (Postgres).
* **@react-pdf/renderer:** To generate the PDF binary on the client side.
* **TypeScript:** Because a Resume data structure is complex and prone to typos.

## Technical Highlights

### 1. Performance: Debounced PDF Rendering
Rendering a PDF document in the browser is computationally expensive. To prevent the UI from freezing while the user types:
* Implemented `use-debounce` to delay the PDF regeneration loop until the user stops typing for **500ms**.
* **Result:** A smooth typing experience with zero input lag, despite complex re-rendering occurring in the background.

### 2. Architecture: Hybrid Data Strategy
I engineered a dual-persistence strategy to handle the difference between a "Template" and an "Application":
* **Master Template:** Synced to `localStorage`. This allows for instant load times and offline editing for the user's core data.
* **Job Resumes:** Synced to **Supabase**. This ensures specific applications are backed up securely and accessible from any device.
* **Code Reuse:** The `ResumeEditorLayout` uses a wrapper pattern to inject different save handlers (Local vs. Cloud) into the same UI component, maximizing code reuse.

### 3. Optimization: Dynamic Imports
The PDF rendering engine significantly increases bundle size. I utilized Next.js `dynamic` imports to lazy-load the preview component only when the browser is idle or the specific tab is active.
```tsx
const PDFPreview = dynamic(
  () => import('@/components/pdf/PDFViewerComponent'),
  { ssr: false, loading: () => <Spinner /> }
);
```

## How to Run

To run the development server locally:

1.  **Clone the repo**
    ```bash
    git clone https://github.com/AldoFurlani/EmployMe.git
    ```
2.  **Install dependencies**
    ```bash
    npm install
    ```
3.  **Environment Setup**
    Create a `.env.local` file with your Supabase credentials (URL and Anon Key). 

4. **Initialize the Database**
   To set up the tables and security policies (RLS):
   * Open your [Supabase Dashboard](https://app.supabase.com/).
   * Select the **SQL Editor** from the left sidebar.
   * Create a **New Query**.
   * Copy the entire contents of `schema.sql` from this repo and paste it into the editor.
   * Click **Run**.
    

5.  **Run the app**
    ```bash
    npm run dev
    ```
