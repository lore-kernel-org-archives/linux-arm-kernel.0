From: x0132446@ti.com (David Anders)
Date: Wed,  6 Oct 2010 16:20:16 -0500
Subject: [PATCH 0/4] omap4: pandaboard: machine cleanups
Message-ID: <1286400020-1010-1-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PandaBoard machine file related cleanups.

David Anders (4):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: Adding card detect support for MMC1
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 7 deletions(-)
