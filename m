From: steve@sakoman.com (Steve Sakoman)
Date: Wed,  9 Mar 2011 12:20:53 -0800
Subject: [PATCH 0/2] OMAP: Overo: Add gpio-leds and gpio-keys support
Message-ID: <1299702055-12480-1-git-send-email-steve@sakoman.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Overo COMs and expansion boards have three LEDS and 2 push button switches
connected to GPIO pins.  This patch series adds support for utilizing
them with gpio-keys and gpio-leds.

Steve Sakoman (2):
  OMAP: Add gpio-leds support for Overo
  OMAP: Add gpio-keys support for Overo

 arch/arm/mach-omap2/board-overo.c |   93 +++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)
