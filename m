From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:42:14 -0800
Subject: [PATCH 0/4] arm: mach-mmp: Allow correct PXA Selections
Message-ID: <1FB4110A-A461-4F8B-9425-44005824005C@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Patch Set 1/12

a) inconsistent behavior when board is selected and if
menu item is reselected board has disappeard

b) Ability to select options that will not build
	MMP2 and say PXA168

The behavior maps what is done by the mach-omap
(thanks to Anrd Bergmann for his help and suggestions)

Mach-MMP is (as now) the sytem type.  Once selected
the user can then select the SoC on the board and
only the boards that support that SoC are shown.

[PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone and SoC Selection
[PATCH 3/4] arm: configs: update pxa168 defconfig for SoC Selection
[PATCH 4/4] arm: configs: update pxa910 defconfig for SoC Selection

update defconfig to reflect the changes made in Patch 1.
