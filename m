From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 15:10:11 +0530
Subject: [PATCH 0/5] ARM: OMAP2+: System timer updates
In-Reply-To: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Message-ID: <510A3BFB.5050805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013 10:34 PM, Jon Hunter wrote:
> This series consists mainly of clean-ups for clockevents and
> clocksource timers on OMAP2+ devices. The most significant change
> in functionality comes from the 5th patch which is changing the
> selection of the clocksource timer for OMAP3 and AM335x devices
> when gptimers are used for clocksource. This change came about from
> Vaibhav Bedia's series for AM335x [1]. See patch for more details on
> the exact nature of the change.
>
> Boot tested with and without  device-tree on OMAP2420 H4,
> OMAP3430 SDP, OMAP3430 Beagle Board, OMAP4430 SDP and
> AM335x EVM (AM335x only supports device-tree boot).
>
> This series is based upon ARM-SoC next branch.
>
> [1] https://patchwork.kernel.org/patch/1921421/
>
> Jon Hunter (5):
>    ARM: OMAP2+: Display correct system timer name
>    ARM: OMAP2+: Remove hard-coded test on timer ID
>    ARM: OMAP2+: Simplify system timer clock definitions
>    ARM: OMAP2+: Simplify system timers definitions
>    ARM: OMAP3: Update clocksource timer selection
>
Nice work Jon. All the patches in the series looks good
to my eyes.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
