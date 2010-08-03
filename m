From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue,  3 Aug 2010 11:20:43 +0200
Subject: [PATCH 0/2] Add camera support for i.MX27 Baseboards
Message-ID: <1280827245-5762-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey everyone,

this baseboard code adds support for the cameras mt9m001,
mt9v022 and mt9m131/mt9m111.

Thanks,
Michael

Michael Grzeschik (2):
  ARM: i.MX27 pcm970: Add camera support
  ARM: i.MX27 pca100: Add camera support

 arch/arm/mach-imx/mach-pca100.c      |  135 +++++++++++++++++++++++++++-
 arch/arm/mach-imx/pcm970-baseboard.c |  165 ++++++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+), 2 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
