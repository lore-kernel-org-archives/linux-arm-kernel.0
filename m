From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 12 May 2014 17:26:47 +0900
Subject: [PATCH 0/2] ARM: tegra: basic support for NVIDIA SHIELD
Message-ID: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT for SHIELD, hopefully in time for 3.16.

Almost everything we could enable at this stage is here. Only the DSI
panel is still missing, I could not get it to work without workarounds
for some reason. Will try to fix that and submit a fixup patch.

Without the panel working this DT is not so useful currently, but it
would be great if we could at least validate it and secure it for 3.16,
so panel support could make it during the -rc cycle.

Thanks,
Alex.

Alexandre Courbot (2):
  ARM: tegra: joystick input in tegra_defconfig
  ARM: tegra: add device tree for SHIELD

 arch/arm/boot/dts/Makefile          |    1 +
 arch/arm/boot/dts/tegra114-roth.dts | 1113 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig    |    1 +
 3 files changed, 1115 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra114-roth.dts

-- 
1.9.2
