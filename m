From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 09:46:09 -0700
Subject: Outstanding Tegra I2C patches
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D5A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

There are a number of patches to the Tegra I2C driver that have been
posted and outstanding for a while:

[PATCH] i2c: Tegra: Add of_match_table
http://www.spinics.net/lists/linux-i2c/msg05898.html

[PATCH] i2c: tegra: add I2C_FUNC_SMBUS_EMUL to adapter functionality
http://www.spinics.net/lists/linux-i2c/msg05396.html

[PATCH] i2c: tegra: fix possible race condition after tx
http://www.spinics.net/lists/linux-i2c/msg06103.html

Could these please be merged so they make it into 3.2? If not the last,
then at least the first two.

I can repost these if you need.

Thank you.

-- 
nvpublic
