From: x0132446@ti.com (David Anders)
Date: Thu,  7 Oct 2010 14:36:27 -0500
Subject: [PATCH 0/3] omap4: pandaboard: machine cleanups
Message-ID: <1286480190-20632-1-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PandaBoard machine file related cleanups.

David Anders (3):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   69 +++++++++++++++++++++++++++++---
 1 files changed, 63 insertions(+), 6 deletions(-)
