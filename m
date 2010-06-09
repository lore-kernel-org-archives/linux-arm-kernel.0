From: jason.mcmullan@netronome.com (Jason S. McMullan)
Date: Wed,  9 Jun 2010 10:35:37 -0400
Subject: kirkwood: USB OTG support
Message-ID: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch leverages the Freescale USB OTG driver
to provide support for the Kirkwood. Both SoCs use the
ARC International USB OTG core IP.

diffstat:
 arch/arm/mach-kirkwood/common.c |   34 +++++++++++++++++++++++++++++-----
 arch/arm/mach-kirkwood/common.h |    1 +
 drivers/usb/gadget/Kconfig      |    2 +-
 3 files changed, 31 insertions(+), 6 deletions(-)
