From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 21:04:21 +0100
Subject: [PATCH 0/4] ARM: mvebu/kirkwood: NETGEAR ReadyNAS .dts files cleanup
Message-ID: <cover.1385148929.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series provides some cleanup for all NETGEAR ReadyNAS .dts files
(Duo v2, 102 and 104). This is mostly based on suggestions from
Sebastian during RN2120 .dts submission. Jason, two remarks:

 - Patch 1/4 applies on top of gpio-poweroff patch for Duo v2 pushed
   earlier today (more precisely v2 of that patch)
 - Patch 3/4 applies on NXP PCA 9554 patch for RN104

As requested, last patch (4/4) contains whitespace cleanups for those
.dts (in fact, mainly Duo v2 and a single hunk for RN102). 

Comments welcome,

Cheers,

a+

Arnaud Ebalard (4):
  ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts file cleanup
  ARM: mvebu: NETGEAR ReadyNAS 102 .dts file cleanup
  ARM: mvebu: NETGEAR ReadyNAS 104 .dts file cleanup
  ARM: NETGEAR ReadyNAS Duo v2 and RN102 .dts file whitespace cleanup

 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 81 +++++++++++-------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 66 +++++++--------
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 98 +++++++++++++---------
 3 files changed, 141 insertions(+), 104 deletions(-)

-- 
1.8.4.4
