From: holler@ahsoftware.de (Alexander Holler)
Date: Wed,  6 Apr 2011 22:35:19 +0200
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and Seagate
	DockStars
Message-ID: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

it seems the time is right to submit these 2 patches.

The first patch merges the setup for Seagate DockStars into the setup
for Marvell SheevaPlugs and the second one removes the machine type for
DockStars at all.

Removing the machine type for DockStar shouldn't be a big problem. Support
for them is already broken in mainline U-Boot since 2 versions, so changing the
stuff there is already needed and it shouldn't be a problem to use the same
machine type as used for SheevaPlugs there.

And if someone really can't change his bootloader to use the same machine type
for DockStars as for SheevaPlugs, he still could revert the second patch.

Regards,

Alexander Holler
