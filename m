From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:26:43 -0500
Subject: [PATCH 0/3] Keystone defconfig updates
Message-ID: <20170718032646.29389-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

The following patch series adds the necessary defconfig options to
keystone_defconfig to enable the TI-SCI protocol and their respective
genpd/clock/reset drivers.

This is the first of two series that provides a baseline for adding
and/or enabling other peripherals on the 66AK2G platforms. Patches are
baselined on 4.13-rc1 and are intended for the 4.14 merge window.

regards
Suman

Nishanth Menon (2):
  ARM: configs: keystone: Enable Message Manager
  ARM: configs: keystone: Enable TI-SCI protocol and genpd driver

Suman Anna (1):
  ARM: configs: keystone: Enable reset drivers

 arch/arm/configs/keystone_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.13.1
