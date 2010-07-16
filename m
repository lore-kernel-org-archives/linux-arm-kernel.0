From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 22:13:16 +0900
Subject: [PATCH 0/3] Add support I2C devices on SMDK6440, SMDKC110 and SMDKV210
Message-ID: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches is to support I2C devices on SMDK6440, SMDKC110 and SMDKV210.
S5P6440 can support I2C channel 0 and 1, and S5PV210/S5PC110 can support
I2C channel 0, 1 and 2.

[PATCH 1/3] ARM: S5P6440: Add support for I2C channel 0 and 1 on SMDK6440
[PATCH 2/3] ARM: S5PV210: Add support for I2C devices on SMDKV210 and SMDKC110
[PATCH 3/3] i2c/busses: Select I2C bus support for S5PV210 and S5P6440.
