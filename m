From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 12:46:55 +0900
Subject: [PATCH 0/2] ARM: shmobile: marzen: defconfig updates for v3.10
Message-ID: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the this short series updates the defconfig for marzen for changes
made by the following patches which I plan to queue-up for v3.10 shortly.

1. ARM: shmobile: marzen: Add GPIO LEDs
2. gpio: Renesas R-Car GPIO driver V3

The patches in this series are:

Simon Horman (2):
  ARM: shmobile: marzen: defconfig: add GPIO RCAR driver support
  ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver

 arch/arm/configs/marzen_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

-- 
1.7.10.4
