From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 May 2012 06:21:47 -0700
Subject: Regression for non-eMMC cards with commit fa550189?
Message-ID: <20120528132147.GC12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf & Chris,

Looks like commit fa550189 (mmc: core: Prevent eMMC VCC supply to be
cut from late init) causes MMC card to stop working at least with
n8x0 using drivers/mmc/host/omap.c. The card(s) on it are not eMMC.

Reverting fa550189 makes things work again. Any ideas what could
be causing this?

No debug output from MMC_DEBUG, looks like commands won't even
get started?

Regards,

Tony
