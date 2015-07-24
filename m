From: mikhail.ulyanov@cogentembedded.com (Mikhail Ulyanov)
Date: Fri, 24 Jul 2015 16:25:44 +0300
Subject: [PATCH 0/2] ARM: shmobile: Add JPU device nodes to Renesas R-Car SoCs.
Message-ID: <1437744346-499-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches contains device tree nodes definitions for JPEG
codec peripheral found in the Renesas R-Car SoCs.

This series of patches is against the renesas-devel-20150720-v4.2-rc3
of https://kernel.googlesource.com/pub/scm/linux/kernel/git/horms/renesas

The driver itself was accepted by Hans Verkuil
http://git.linuxtv.org/cgit.cgi/hverkuil/media_tree.git
commit hash 761a0eee505f3a7051b187e67cd28c50b385d409

Mikhail Ulyanov (2):
  ARM: shmobile: r8a7790: Add JPU device node.
  ARM: shmobile: r8a7791: Add JPU device node.

 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

-- 
2.1.4
