From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Jun 2013 21:15:25 +0200
Subject: [PATCH 0/2] R-Car GPIO fixes
Message-ID: <1371496527-13149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are two small fixes for the gpio-rcar driver. I would push them through
the GPIO tree if it wasn't for the fact that they're based on gpio-rcar DT
support, scheduled for merge through the ARM SoC tree.

Simon, as these patches are fixes, would it be possible to get them in v3.11
through your tree ?

Laurent Pinchart (2):
  gpio-rcar: Reference core gpio documentation in the DT bindings
  gpio-rcar: Remove #ifdef CONFIG_OF around OF-specific sections

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt     | 18 ++++++------------
 drivers/gpio/gpio-rcar.c                               |  8 ++------
 2 files changed, 8 insertions(+), 18 deletions(-)

-- 
Regards,

Laurent Pinchart
