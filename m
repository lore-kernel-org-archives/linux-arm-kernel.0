From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Aug 2015 03:43:56 -0700
Subject: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Message-ID: <20150805104355.GE16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
> Patch series implements voltage switching and tuning for omap_hsmmc
> driver.
> 
> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.

Your tests are missing omap3?

I suggest you add some omap3 tests in general as otherwise you are
only testing a subset of the driver features and completely missing
things like rutnime PM and save and restore for the deeper idle
states.

Regards,

Ton
