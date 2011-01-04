From: balbi@ti.com (Felipe Balbi)
Date: Tue,  4 Jan 2011 14:02:53 +0200
Subject: [PATCH 0/4] ARM IRQ Changes
Message-ID: <1294142577-28772-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

a few patches to enable sparse IRQ numbering on OMAP.
Also a few cleanups to arch/arm/Kconfig.

for convenience patches are also available from [1]:

[1] git://gitorious.org/usb/usb.git irq

Felipe Balbi (4):
  arm: omap: gpio: don't access irq_desc array directly
  arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
  arm: Kconfig: remove duplicated SPARSE_IRQ entry
  arm: Kconfig: allow OMAP to use sparse IRQ numbering

 arch/arm/Kconfig          |   22 ++++------------------
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 2 files changed, 11 insertions(+), 21 deletions(-)

-- 
1.7.3.4.598.g85356
