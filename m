From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 14:46:19 -0700
Subject: [PATCH] ARM: OMAP: zoom: Use pwm stack for lcd and keyboard
 backlight
In-Reply-To: <513DCA13.40705@ti.com>
References: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
 <513DCA13.40705@ti.com>
Message-ID: <20130408214618.GY10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130311 05:16]:
> On 2013-03-11 13:57, Peter Ujfalusi wrote:
> > Use pwm_leds driver for the keyboard light and pwm-backlight for the lcd
> > backlight control (instead of implementing the PWM driver part in the board
> > file).
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-zoom-display.c     | 56 ----------------------------
> >  arch/arm/mach-omap2/board-zoom-peripherals.c | 53 +++++++++++++++++++++++++-
> >  2 files changed, 52 insertions(+), 57 deletions(-)
> 
> I can't test this, but looks fine to me. Good to get rid of the hacky
> backlight code in board-zoom-display.c.

Thanks applying into omap-for-v3.10/board.

Tony
