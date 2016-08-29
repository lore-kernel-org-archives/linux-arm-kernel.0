From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2016 11:02:32 +0100
Subject: [PATCH 0/3] SA11x0/PXA pcmcia fixes
Message-ID: <20160829100232.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Further to the DS suspend/resume fix, here's a few more for SA11x0/PXA.

 drivers/pcmcia/sa11xx_base.c | 8 ++++----
 drivers/pcmcia/soc_common.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
