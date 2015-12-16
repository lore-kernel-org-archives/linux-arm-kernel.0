From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 16 Dec 2015 11:34:19 +0100
Subject: [PATCH v2 0/2] SATA for r8a7795, Salvator-X
Message-ID: <1450262061-1441-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This is an adaptation of the patch set from the BSP, adjusted to the new PFC
and MSTP clock models.

This revision drops the patches that have been picked up by Simon and Geert,
incrementally fixes the incorrect clock assignment, and drops the
unnecessary pin assignment from the DT.

CU
Uli


Changes since v1:
- drop picked up patches
- drop superfluous pin assignment
- fix SATA clock assignment (915 -> 815)

Ulrich Hecht (2):
  clk: shmobile: r8a7795: Add SATA0 clock
  arm64: dts: r8a7795: fix SATA clock assignment

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 drivers/clk/shmobile/r8a7795-cpg-mssr.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.6.3
