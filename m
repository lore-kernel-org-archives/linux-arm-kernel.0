From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 19 Dec 2014 12:45:12 +0200
Subject: [PATCH 0/2] ARM: OMAP DSS hwmod reset fix
Message-ID: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are similar patches for AM43xx and DRA7xxx than was done earlier for
OMAP4/5 in

543b2847d4bdb07eb1b50003095bc65cf2a1e2c0
 ("ARM: OMAP4: hwmod: set DSS submodule parent hwmods")

and

9ed69650897e8738c959fe8242ec41499f3f3f35
("ARM: OMAP5: hwmod: set DSS submodule parent hwmods")

I don't think missing the reset causes any problems, but the boot time warnings
are annoying.

 Tomi

Tomi Valkeinen (2):
  ARM: AM43xx: hwmod: set DSS submodule parent hwmods
  ARM: DRA7xx: hwmod: set DSS submodule parent hwmods

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.2.0
