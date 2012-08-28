From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:01 +0200
Subject: arm: move plat-orion platform_data headers to the right place
Message-ID: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

plat-orion/include/plat contains a bunch of headers with platform_data
structure definitions. Those headers should now be in
<linux/platform_data/...>, so this patch series is moving them
here. This impacts the MTD, USB EHCI, sound, MMC, DMA XOR drivers.

Moreover, this series takes this opportunity to move two other
platform_data headers that were in <linux/...>. This impacts the I2C
and Ethernet drivers.

This series has been built tested for orion5x_defconfig,
dove_defconfig, kirkwood_defconfig and mv78x00_defconfig.

Thanks,

Thomas
