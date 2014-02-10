From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Feb 2014 22:54:39 +0100
Subject: [PATCH 0/5] mt9t001 and mt9p031 sensors drivers patches
Message-ID: <1392069284-18024-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a set of miscellaneous patches for the mt9t001 and mt9p031 sensors
drivers. Please see individual commit messages for details.

The mt9t001 driver receives support for regulators and clocks. As a
prerequisite, patch 1/5 registers a fixed rate clock and two fixed voltage
regulators for the CM-T35 board camera sensor.

Laurent Pinchart (5):
  ARM: omap2: cm-t35: Add regulators and clock for camera sensor
  mt9t001: Add regulator support
  mt9t001: Add clock support
  mt9p031: Fix typo in comment
  mt9p031: Add support for PLL bypass

 arch/arm/mach-omap2/board-cm-t35.c |  16 +++
 drivers/media/i2c/mt9p031.c        |  34 +++++-
 drivers/media/i2c/mt9t001.c        | 229 +++++++++++++++++++++++++++++--------
 3 files changed, 228 insertions(+), 51 deletions(-)

-- 
Regards,

Laurent Pinchart
