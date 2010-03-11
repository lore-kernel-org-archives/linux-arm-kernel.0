From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 10:03:16 -0800
Subject: [PATCH 0/3] USB compile fixes omaps
Message-ID: <20100311180023.20537.27516.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe & Greg,

Here are three fixes to make USB compile for omaps.
Can you please take a look and queue?

The tusb6010 DMA fix needs a platform init patch that I'll
send along with other omap fixes.

Regards,

Tony


---

Tony Lindgren (3):
      usb: Fix compile error for omaps for musb_hdrc
      usb: Fix USB_SUSPEND dependency for OTG
      usb: Fix tusb6010 for DMA API


 drivers/usb/core/Kconfig         |    2 +-
 drivers/usb/musb/musb_core.h     |    4 ++--
 drivers/usb/musb/tusb6010.c      |   13 +++++++++++++
 drivers/usb/musb/tusb6010_omap.c |   22 ++++++++++++++--------
 4 files changed, 30 insertions(+), 11 deletions(-)

-- 
Signature
