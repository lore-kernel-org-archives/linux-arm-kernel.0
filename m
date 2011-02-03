From: rnayak@ti.com (Rajendra Nayak)
Date: Thu,  3 Feb 2011 17:01:43 +0530
Subject: [PATCH 0/2] Fix/Clean regulator consumer mapping for 3430sdp
Message-ID: <1296732705-12818-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a short series to fix some, and clean the
existing regulator consumer supply mappings for
the OMAP3430sdp board.

The series is boot tested on the 3430sdp board
and applies on 2.6.38-rc3.

Rajendra Nayak (2):
  omap3sdp: Fix regulator mapping for ads7846 TS controller
  omap3sdp: clean regulator supply mapping in board file

 arch/arm/mach-omap2/board-3430sdp.c |   60 +++++++++++++++--------------------
 1 files changed, 26 insertions(+), 34 deletions(-)
