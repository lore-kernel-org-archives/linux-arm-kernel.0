From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 24 Oct 2014 23:21:52 +0200
Subject: [PATCHv0 0/2] arm: mvebu: non-critical fixes for NETGEAR ReadyNAS 102
Message-ID: <cover.1414185031.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This two patches are non-critical and respectively fix the following
in RN102 .dts file:
 - the color for LEDs labels (they are blue, and not green)
 - eSATA/SATA ports info

Arnaud Ebalard (2):
  arm: mvebu: fix LED color in NETGEAR ReadyNAS 102 .dts file
  arm: mvebu: clarify (e)SATA ports info in NETGEAR ReadyNAS 102 .dts file

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.1.1
