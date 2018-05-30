From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 May 2018 08:28:25 -0700
Subject: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
In-Reply-To: <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com>
 <20180530145047.GC5705@atomide.com>
 <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
Message-ID: <20180530152825.GG5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [180530 15:18]:
> For the OCP if part, I think that is still needed until we switch over to
> full sysc driver. clkctrl_offs you probably also need because that is used
> for mapping the omap_hwmod against a specific clkctrl clock. Those can be
> only removed once we are done with hwmod (or figure out some other way to
> assign the clkctrl clock to a hwmod.)

Hmm might be worth testing. I thought your commit 70f05be32133
("ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available")
already parses the clkctrl from dts?

Regards,

Tony
