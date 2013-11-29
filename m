From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 29 Nov 2013 21:27:13 +0100
Subject: [PATCHv2 0/4] ARM: mvebu/kirkwood: NETGEAR ReadyNAS .dts files cleanup
Message-ID: <cover.1385756371.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series provides some cleanup for all NETGEAR ReadyNAS .dts files
(Duo v2, 102 and 104). This is mostly based on suggestions from
Sebastian during RN2120 .dts submission. Jason, two remarks:

 - Patch 1/4 applies on top of previous gpio-poweroff patch for Duo v2
 - Patch 3/4 applies on NXP PCA 9554 patch for RN104

As requested, last patch (4/4) contains whitespace cleanups for those
.dts (in fact, mainly Duo v2 and a single hunk for RN102).

This v2 mainly removes PHY compatible strings for simple comments.

Comments welcome,

Cheers,

a+

Arnaud Ebalard (4):
  ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts cleanup
  ARM: mvebu: NETGEAR ReadyNAS 102 .dts cleanup
  ARM: mvebu: NETGEAR ReadyNAS 104 .dts cleanup
  ARM: Fix whitespaces in NETGEAR ReadyNAS .dts files

 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 82 ++++++++++--------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 68 +++++++--------
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 99 +++++++++++++---------
 3 files changed, 141 insertions(+), 108 deletions(-)

-- 
1.8.4.4
