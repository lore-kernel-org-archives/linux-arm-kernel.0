From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 19 May 2010 11:31:52 +0200
Subject: [PATCH 0/2 v2] MX3X: Architecture specific mx3 keypad support
Message-ID: <1274261512.3123.6.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two patches add the support for the keypad device
over the recent merge of the imx-keypad driver and shows
how to support this device into the machine file.

v2: Pin definition helpers are placed in iomux-mx3.h

Alberto Panizzo (2):
  MX3X: Add Keypad device definition for MX3X arch
  mx31_3ds: Support the keypad situated in the personality board

 arch/arm/mach-mx3/devices.c                |   19 ++++++++++++++++
 arch/arm/mach-mx3/devices.h                |    1 +
 arch/arm/mach-mx3/mach-mx31_3ds.c          |   32 ++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |   17 ++++++++++++++
 4 files changed, 69 insertions(+), 0 deletions(-)
