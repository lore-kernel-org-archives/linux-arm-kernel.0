From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Jan 2016 08:20:16 +1100
Subject: [PATCH v2 0/3] ARM: shmobile: r8a779x: use fallback usbhs
 compatibility string
Message-ID: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes use of the recently added fallback usbhs
compatibility string in the r8a779[014] device trees.

Based on renesas-devel-20151228-v4.4-rc7.

Changes since v1:
* Use "renesas,rcar-gen2-usbhs" instead of "renesas,usbhs"

Simon Horman (3):
  ARM: shmobile: r8a7790: use fallback usbhs compatibility string
  ARM: shmobile: r8a7791: use fallback usbhs compatibility string
  ARM: shmobile: r8a7794: use fallback usbhs compatibility string

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.1.4
