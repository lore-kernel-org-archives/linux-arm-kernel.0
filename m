From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Jan 2016 13:52:44 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a777[89]: use GIC_* defines
Message-ID: <1453351966-10968-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series uses GIC_* defines in the r8a779[34] device trees as
appropriate.

This is a follow-up for similar work for the r8a779[0134] SoCs.
I plan to post follow up patches to update the device trees for
other Renesas SoCs depending on the success of this series.

Based on renesas-devel-20160118-v4.4

Simon Horman (2):
  ARM: dts: r8a7778: use GIC_* defines
  ARM: dts: r8a7779: use GIC_* defines

 arch/arm/boot/dts/r8a7778.dtsi | 87 +++++++++++++++++++++---------------------
 arch/arm/boot/dts/r8a7779.dtsi | 78 ++++++++++++++++++-------------------
 2 files changed, 83 insertions(+), 82 deletions(-)

-- 
2.1.4
