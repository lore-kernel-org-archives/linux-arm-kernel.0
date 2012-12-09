From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 9 Dec 2012 20:34:42 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: Fix EMU clock domain always on
In-Reply-To: <1354911994-20045-1-git-send-email-jon-hunter@ti.com>
References: <1354911994-20045-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1212092033450.351@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Fri, 7 Dec 2012, Jon Hunter wrote:

> Commit d043d87 (ARM: OMAP2+: clockdomain: bypass clockdomain handling
> when disabling unused clks) skips the decrementing of a clock-domains
> use count if the clocks use count is zero. However, for OMAP4 devices
> this is causing the EMU clock-domain to be stuck ON as the use count is
> not getting decremented correctly.

Thanks for the fix and the great patch description; queued for v3.8-rc.


- Paul
