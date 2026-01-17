import AppShell from "@/components/layout/AppShell"

export default function DashboardPage() {
  return (
    <AppShell>
      <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
        {/* Left */}
        <div className="rounded-lg border p-4">
          <h2 className="font-semibold">Notifications</h2>
          <p className="text-sm text-muted-foreground">
            Upcoming follow-ups
          </p>
        </div>

        {/* Center */}
        <div className="md:col-span-1 rounded-lg border p-4">
          <h2 className="font-semibold">Application Flow</h2>
          <p className="text-sm text-muted-foreground">
            Sankey diagram placeholder
          </p>
        </div>

        {/* Right */}
        <div className="rounded-lg border p-4">
          <h2 className="font-semibold">Momentum</h2>
          <p className="text-sm text-muted-foreground">
            Weekly activity
          </p>
        </div>
      </div>
    </AppShell>
  )
}
