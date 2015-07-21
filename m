From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 21 Jul 2015 22:43:57 +0800
Subject: [PATCH 0/3] arm64: remove paragraph about writing to FSF
Message-ID: <1437489840-2368-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches remove paragraph about writing to FSF in arch/arm64 dir.

Jisheng Zhang (3):
  arm64: hugetlb: remove paragraph about writing to FSF
  arm64: dts: cavium: remove paragraph about writing to FSF
  arm64: dts: freescale: remove paragraph about writing to FSF

 arch/arm64/boot/dts/cavium/thunder-88xx.dts        | 5 -----
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       | 5 -----
 arch/arm64/boot/dts/freescale/fsl-ls2085a-simu.dts | 5 -----
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     | 5 -----
 arch/arm64/include/asm/hugetlb.h                   | 4 ----
 arch/arm64/mm/hugetlbpage.c                        | 4 ----
 6 files changed, 28 deletions(-)

-- 
2.1.4
