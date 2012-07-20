From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 20 Jul 2012 20:09:34 +0530
Subject: [PATCH 0/2] ARM: davinci: add support for dm355 vpbe display driver
Message-ID: <1342795176-17631-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables VPBE display driver on DM355.

Manjunath Hadli (2):
  ARM: davinci: dm355: add support for v4l2 video display
  ARM: davinci: dm355 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm355-evm.c |   73 ++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm355.c           |  216 +++++++++++++++++++++++++++++-
 3 files changed, 280 insertions(+), 11 deletions(-)
