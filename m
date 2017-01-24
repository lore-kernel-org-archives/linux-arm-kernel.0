From: eric@anholt.net (Eric Anholt)
Date: Mon, 23 Jan 2017 16:38:51 -0800
Subject: [PATCH 0/2] drm/vc4: DSI display output support
Message-ID: <20170124003853.16418-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend from a month ago of just two of the patches (several
are accepted at this point) from the DSI series, hoping to collect an
ack from DT.  Ccing the clock folks as well, since this ends up being
a clock provider.

Eric Anholt (2):
  dt-bindings: Document the VC4 DSI module nodes.
  drm/vc4: Add DSI driver

 .../devicetree/bindings/display/brcm,bcm-vc4.txt   |   35 +
 drivers/gpu/drm/vc4/Kconfig                        |    2 +
 drivers/gpu/drm/vc4/Makefile                       |    1 +
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |    1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |    1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |    5 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      | 1725 ++++++++++++++++++++
 7 files changed, 1770 insertions(+)
 create mode 100644 drivers/gpu/drm/vc4/vc4_dsi.c

-- 
2.11.0
