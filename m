From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue, 15 May 2018 13:29:26 +0100
Subject: [PATCH 0/3] enable ccree on Renesas R-Car platform
Message-ID: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch set enables CryptoCell present in the Renesas
R-Car SoC.

Gilad Ben-Yossef (3):
  crypto: ccree: drop signature register check
  clk: renesas: r8a7795: Add ccree clock
  arm64: dts: renesas: r8a7795: add ccree binding

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  8 ++++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c   |  1 +
 drivers/crypto/ccree/cc_driver.c         | 18 +++---------------
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.7.4
