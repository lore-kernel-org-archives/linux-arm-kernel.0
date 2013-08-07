From: wni@nvidia.com (Wei Ni)
Date: Wed, 7 Aug 2013 14:52:36 +0800
Subject: [PATCH 0/2] Add power control for lm90
Message-ID: <1375858358-15070-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device lm90 can be controlled by the vdd rail.
Add function to power on/off the vdd.
Enable the nct1008 on Tegra114 Dalmore board, and set the vdd-regulator.

Wei Ni (2):
  hwmon: (lm90) Add power control
  ARM: dt: t114 dalmore: add dt entry for nct1008

 arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++-
 drivers/hwmon/lm90.c                   |   52 ++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

-- 
1.7.9.5
