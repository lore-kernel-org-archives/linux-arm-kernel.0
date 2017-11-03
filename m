From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Nov 2017 17:54:44 +0100
Subject: [PATCH v2 0/2] ARM: dts: exynos: Updates for Odroid HDMI audio
References: <CGME20171103165505epcas2p18afcabc3651639d246df4e8255fb34c9@epcas2p1.samsung.com>
Message-ID: <20171103165446.15438-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are intended for v4.16-rc1 as they depend on the HDMI
codec patch which is going to be merged in coming merge window.

Sylwester Nawrocki (2):
  ARM: dts: exynos: Switch to dedicated Odroid-XU3 sound card binding
  ARM: dts: exynos: Add sound support for Odroid XU4

 arch/arm/boot/dts/exynos4.dtsi                    |  1 +
 arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 60 ++++++++++++++---------
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        | 52 ++++++++++++++++++++
 4 files changed, 92 insertions(+), 22 deletions(-)

--
2.14.2
