From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 17 Apr 2017 23:42:43 +0200
Subject: [PATCH 0/1] add missing L2 cache properties for Meson8 and Meson8b
Message-ID: <20170417214244.23698-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds three missing L2 cache properties for the cache controller
on Meson8 and Meson8b.

This patch was originally written by Carlo Caione, I just took it and
applied it to Meson8 as well and rebased it.

This patch is based on my previous series from [0]: "Amlogic Meson (32-bit)
.dts cleanups"


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-April/003399.html

Carlo Caione (1):
  ARM: dts: meson: Extend L2 cache controller node for Meson8 and
    Meson8b

 arch/arm/boot/dts/meson8.dtsi  | 6 ++++++
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

-- 
2.12.2
