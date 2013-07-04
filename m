From: wni@nvidia.com (Wei Ni)
Date: Thu, 4 Jul 2013 17:09:37 +0800
Subject: [PATCH 0/2] Enable lm90 in Tegra30 and Tegra114.
Message-ID: <1372928979-26938-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable thermal sensor lm90 for Tegra30 Cardhu and Tegra114 Dalmore.

This series is v1, based on [RFC 1/9] submitted here:
http://thread.gmane.org/gmane.linux.power-management.general/31056

Changes from RFC:
1. Enable it for Tegra114 Dalmore.

Wei Ni (2):
  ARM: dt: t30 cardhu: add dt entry for lm90
  ARM: dt: t114 dalmore: add dt entry for lm90

 arch/arm/boot/dts/tegra114-dalmore.dts |    7 +++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |    7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.7.9.5
