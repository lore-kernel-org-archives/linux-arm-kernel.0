From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 17 Jul 2017 10:36:02 +0200
Subject: [PATCH 0/3] ARM: dts: stm32: Remove rdinit from bootargs
Message-ID: <1500280565-26049-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series remove rdinit from bootargs on stm32f4 boards (429-eval,
429-disco, 469-disco). Indeed, rootfs is independent from boards.
Furthermore it will align stm32 F4 devicetree on stm32 F7/H7 one.

Regards
Alex

Alexandre TORGUE (3):
  ARM: dts: stm32: Remove rdinit from bootargs on stm32f469-disco
  ARM: dts: stm32: Remove rdinit from bootargs on stm32f429i-eval
  ARM: dts: stm32: Remove rdinit from bootargs on stm32f429-disco

 arch/arm/boot/dts/stm32429i-eval.dts  | 2 +-
 arch/arm/boot/dts/stm32f429-disco.dts | 2 +-
 arch/arm/boot/dts/stm32f469-disco.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
