From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Jan 2016 08:33:25 +1100
Subject: [PATCH 0/2] ARM: shmobile: r8a779[01]: use GIC_* defines
Message-ID: <1451856807-8081-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series uses GIC_* defines in the r8a779[01] device trees as
appropriate.

I plan to post follow up patches to update the device trees for
other Renesas SoCs depending on the success of this series.

Based on renesas-devel-20151228-v4.4-rc7

Simon Horman (2):
  ARM: shmobile: r8a7790: use GIC_* defines
  ARM: shmobile: r8a7791: use GIC_* defines

 arch/arm/boot/dts/r8a7790.dtsi | 348 +++++++++++++++++++-------------------
 arch/arm/boot/dts/r8a7791.dtsi | 370 ++++++++++++++++++++---------------------
 2 files changed, 359 insertions(+), 359 deletions(-)

-- 
2.1.4
