From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Sep 2012 15:06:40 +0200
Subject: net: Network driver for the Armada 370 and Armada XP ARM Marvell SoCs
Message-ID: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David, Lennert,

This patch set adds a new network driver for the network unit
available in the newest Marvell ARM SoCs Armada 370 and Armada XP, as
well as the necessary Device Tree information to use this driver in
the two evaluation platforms of those SoCs.

In details:

 * Patch 1 contains the driver itself. The commit log contains a
   detailed explanation about why a new driver is needed for this new
   Marvell SoC, compared to older Marvell SoCs (Orion, Kirkwood, Dove)
   that use the mv643xx_eth driver.

 * Patch 2 adds the necessary entry to the MAINTAINERS file.

 * Patch 3 adds the SoC-level Device Tree information for Armada 370
   and Armada XP.

 * Patch 4 adds the board-level Device Tree information for the
   Marvell evaluation boards of Armada 370 and Armada XP.

Thanks,

Thomas Petazzoni
