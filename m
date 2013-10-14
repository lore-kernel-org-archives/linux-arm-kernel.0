From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 15:28:59 +0200
Subject: [PATCH 0/3] usb: musb bugfixes
Message-ID: <1381757342-13324-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the series contains two bugfixes and some debugfs file operations for dsps
similar to the musb core regdump debugfs file.

Regards,

Markus Pargmann


Markus Pargmann (3):
      usb: musb: Handle nullpointer
      usb: musb: Bugfix of_node assignment
      usb: musb: dsps, debugfs files

 drivers/usb/musb/musb_core.c | 15 +++++++-
 drivers/usb/musb/musb_dsps.c | 90 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 3 deletions(-)
