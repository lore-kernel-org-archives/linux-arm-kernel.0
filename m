From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 31 Oct 2017 23:23:14 +0100
Subject: [PATCH 0/2] update the L2 cache settings on Meson8/Meson8b
Message-ID: <20171031222316.24548-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 cache settings on our mainline kernel did not match the
configuration from Amlogic's vendor kernel.

This was boot-tested on a Meson8 (actually Meson8m2, but both use
the same CPU cores and L2 cache configuration) and a Meson8b board.


Martin Blumenstingl (2):
  ARM: dts: meson8b: add more L2 cache settings
  ARM: dts: meson8: add more L2 cache settings

 arch/arm/boot/dts/meson8.dtsi  | 3 +++
 arch/arm/boot/dts/meson8b.dtsi | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.15.0
