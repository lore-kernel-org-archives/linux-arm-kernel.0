From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Jan 2016 14:18:42 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a779[34]: use GIC_* defines
Message-ID: <1453094324-22404-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series uses GIC_* defines in the r8a779[34] device trees as
appropriate.

This is a follow-up for similar work for the rua779[01] SoCs.
I plan to post follow up patches to update the device trees for
other Renesas SoCs depending on the success of this series.

Based on renesas-devel-20160111-v4.4

Simon Horman (2):
  ARM: dts: r8a7793: use GIC_*defines
  ARM: dts: r8a7794: use GIC_*defines

 arch/arm/boot/dts/r8a7793.dtsi | 216 ++++++++++++++++++++--------------------
 arch/arm/boot/dts/r8a7794.dtsi | 220 ++++++++++++++++++++---------------------
 2 files changed, 218 insertions(+), 218 deletions(-)

-- 
2.1.4
