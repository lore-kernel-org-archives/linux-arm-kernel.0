From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Jul 2011 23:39:32 +0200
Subject: conflicts between omap/cleanup branch and omap_dss2 tree
Message-ID: <201107172339.32516.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul and Tomi,

I'm trying to get the arm-soc tree integrated into linux-next, but right
now that fails because of lots of conflicts in the arch/arm/mach-omap2/clock44xx_data.c
and arch/arm/mach-omap2/omap_hwmod_44xx_data.c files.

I've done a dumb resolution by pulling in the omap_dss2/for_next tree as a
depedency and taking Tomi's version of the files, which is probably wrong 
but lets Stephen at least take the arm-soc tree.

Please fix this properly in either the omap or the omap_dss2 trees.

	Arnd
