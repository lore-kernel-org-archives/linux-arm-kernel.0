From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2016 10:50:29 +0100
Subject: [PATCH 0/4] Input updates for Jornada720
Message-ID: <20160907095029.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry,

Please apply this tested series of patches for Jornada 720 input support.

Thanks.

 arch/arm/mach-sa1100/jornada720.c         | 16 +++++++++++
 drivers/input/keyboard/jornada720_kbd.c   | 48 ++++++++++---------------------
 drivers/input/touchscreen/jornada720_ts.c | 21 +++++++++-----
 3 files changed, 45 insertions(+), 40 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
