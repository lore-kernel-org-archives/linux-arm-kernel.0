From: horms+renesas@verge.net.au (Simon Horman)
Date: Sun, 15 Dec 2013 17:23:58 +0900
Subject: [PATCH RFC 0/2] pinctl: sh-pfc: r7s72100: Ethernet support
Message-ID: <1387095840-15008-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a first pass at adding ethernet support to sh-pfc for
the r7s72100 SoC.

It has been written with reference to the hardware documentation
but not well tested.

This series is based on the topic/r7s72100-v3.13-rc3-20131214v2
tag in my renesas tree.

Simon Horman (2):
  pinctl: sh-pfc: r7s72100: Ethernet support
  ARM: shmobile: r7s72100: Add ethernet PFC node to DT

 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 25 +++++++++-
 drivers/pinctrl/sh-pfc/pfc-r7s72100.c           | 64 +++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

- 
1.8.4
