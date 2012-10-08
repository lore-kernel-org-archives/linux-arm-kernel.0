From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 8 Oct 2012 14:22:49 +0530
Subject: [PATCH 00/16] More omap plat header cleanup for v3.8 merge window
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Message-ID: <50729461.8090504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Friday 05 October 2012 03:34 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some more patches for early merging after -rc1 for v3.8
> merge window to remove more plat includes for the ARM common
> zImage support. These are based on top of current linux next +
> kevin's cpufreq fixes.
>
Have scanned the series and movement looks fine. For the SRAM movement,
I just wanted to to check if the builds are fine with errata WA enabled
for OMAP4. Do you have a branch where you are stacking up these patches?

Regards
santosh
