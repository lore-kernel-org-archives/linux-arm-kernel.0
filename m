From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jan 2014 10:22:34 +0100
Subject: [PATCH v4 0/2] usb: musb dsps updates
Message-ID: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The two remaining patches from the previous series "usb: musb bugfixes". In v4
I used the device name for the debugfs root dir and added a commit message to
the second patch.

Regards,

Markus


Markus Pargmann (2):
  usb: musb: dsps, debugfs files
  usb: musb: dsps, use devm_kzalloc

 drivers/usb/musb/musb_dsps.c | 58 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

-- 
1.8.5.2
