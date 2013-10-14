From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 15:50:36 +0200
Subject: [PATCH v2 0/3] usb: musb bugfixes
Message-ID: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the series contains two bugfixes and some debugfs file operations for dsps
similar to the musb core regdump debugfs file.

v2 removes the dev_info() in patch 3 in dsps_musb_init.

Regards,

Markus Pargmann



Markus Pargmann (3):
      usb: musb: Handle nullpointer
      usb: musb: Bugfix of_node assignment
      usb: musb: dsps, debugfs files

 drivers/usb/musb/musb_core.c | 15 +++++++-
 drivers/usb/musb/musb_dsps.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 3 deletions(-)
