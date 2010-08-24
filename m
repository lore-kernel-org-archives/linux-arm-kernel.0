From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 24 Aug 2010 17:27:01 +0200
Subject: [PATCH 0/2] fix mx35fb display mappings
In-Reply-To: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282663623-8404-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches introduce a fix for the display mappings
in the mx35 framebuffer. It also sets the platformspecific
display mapping for the mx35_3ds development board's tft panel
added with this patch:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/023914.html

Juergen Beisert (2):
  Separate display's pixel configuration from video mode
  mx35_3ds: Make usage of the display connection feature

 arch/arm/mach-mx3/mach-mx35_3ds.c      |   15 ++++++++
 arch/arm/plat-mxc/include/mach/mx3fb.h |    5 +++
 drivers/video/mx3fb.c                  |   62 +++++++++++++-------------------
 3 files changed, 45 insertions(+), 37 deletions(-)
