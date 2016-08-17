From: rogerq@ti.com (Roger Quadros)
Date: Wed, 17 Aug 2016 13:44:49 +0300
Subject: [PATCH 0/1] ARM: Keystone: Fix USB on v4.8-rc
Message-ID: <1471430690-17143-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

USB ports are broken on Keystone2 boards since v4.8-rc1.
This is because CONFIG_KEYSTONE_USB_PHY is no longer being enabled
by keystone_defconfig. Fix that.

Please pick this for the v4.8-rc cycle. Thanks.

cheers,
-roger

Roger Quadros (1):
  ARM: keystone: defconfig: Fix USB configuration

 arch/arm/configs/keystone_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4
