From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 17:02:57 +0800
Subject: [PATCH 0/2] simple device tree support for mxsfb
Message-ID: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds a simple device tree support for mxsfb driver.

Shawn Guo (2):
  video: mxsfb: move mxsfb.h into include/linux
  video: mxsfb: add simple device tree probe

 Documentation/devicetree/bindings/fb/mxsfb.txt     |   21 +++++++
 arch/arm/mach-mxs/devices-mx23.h                   |    2 +-
 arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
 arch/arm/mach-mxs/devices/platform-mxsfb.c         |    2 +-
 drivers/video/mxsfb.c                              |   62 +++++++++++++++-----
 .../include/mach => include/linux}/mxsfb.h         |    6 +-
 6 files changed, 75 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/mxsfb.txt
 rename {arch/arm/mach-mxs/include/mach => include/linux}/mxsfb.h (95%)

-- 
1.7.5.4
