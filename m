From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Thu, 28 Oct 2010 16:43:00 +0200
Subject: [PATCH 0/2] OMAP: DSS2: Add new display panel
Message-ID: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Next patches adds support for the two new LCD panel display used
on IGEP boards.

 Powertip PH480272T LCD 4.3inch (480x242) display
 Seiko 70WVW1TZ3 LCD 7.0inch WVGA (800x480) display

Please, consider adding in next merge window.

Cheers,

Enric Balletbo i Serra (2):
  OMAP: DSS2: Add Powertip PH480272T display panel
  OMAP: DSS2: Add Seiko 70WVW1TZ3 display panel

 drivers/video/omap2/displays/Kconfig               |   14 ++
 drivers/video/omap2/displays/Makefile              |    2 +
 .../omap2/displays/panel-powertip-ph480272t.c      |  155 +++++++++++++++++++
 .../video/omap2/displays/panel-seiko-70wvw1tz3.c   |  157 ++++++++++++++++++++
 4 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-powertip-ph480272t.c
 create mode 100644 drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c
