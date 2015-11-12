From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Nov 2015 11:52:59 -0600
Subject: [PATCH 0/2] arm: beaglex15: fix USB Gadget
Message-ID: <1447350781-20649-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

with the following patches I can get USB Gadget working
with my beagle x15 with today's Linus' tree.

regards

Felipe Balbi (2):
  arm: boot: dts: beaglex15: Remove ID GPIO
  arm: boot: beaglex15: pass correct interrupt

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.6.2
