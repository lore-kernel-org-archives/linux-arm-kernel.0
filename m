From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 20:41:29 +0200
Subject: [PATCH RESEND v6 0/2] ARM: sunxi: Add Reduced Serial Bus (RSB)
 controller support
Message-ID: <1445625691-20289-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

As discussed on IRC, here is a resend of these RSB patches, to merge
for 4.4.

The original cover letter was:

This is v6 of the Allwinner Reduced Serial Bus driver. This version puts
the driver under drivers/bus instead of drivers/soc/sunxi. There are no
changes to the binding or the driver itself.

The series is based on v4.3-rc1.

Thanks!
Maxime

Chen-Yu Tsai (2):
  bus: sunxi-rsb: Add Allwinner Reduced Serial Bus (RSB) controller
    bindings
  bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus

 .../devicetree/bindings/bus/sunxi-rsb.txt          |  47 ++
 drivers/bus/Kconfig                                |  11 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/sunxi-rsb.c                            | 783 +++++++++++++++++++++
 include/linux/sunxi-rsb.h                          | 105 +++
 5 files changed, 947 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/sunxi-rsb.txt
 create mode 100644 drivers/bus/sunxi-rsb.c
 create mode 100644 include/linux/sunxi-rsb.h

-- 
2.6.2
