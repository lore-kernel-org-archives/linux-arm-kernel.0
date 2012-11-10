From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 10 Nov 2012 00:42:56 -0800
Subject: [PATCH 02/10] arm: at91: move platfarm_data to
 include/linux/platform_data/atmel.h
In-Reply-To: <509A5219.2080408@pengutronix.de>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
 <1352287374-25176-2-git-send-email-plagnioj@jcrosoft.com>
 <509A5219.2080408@pengutronix.de>
Message-ID: <20121110084256.GB14761@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 01:20:41PM +0100, Marc Kleine-Budde wrote:
> On 11/07/2012 12:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-ide at vger.kernel.org
> > Cc: linux-input at vger.kernel.org
> > Cc: linux-mmc at vger.kernel.org
> > Cc: linux-can at vger.kernel.org
> > Cc: netdev at vger.kernel.org
> > Cc: linux-pcmcia at lists.infradead.org
> > Cc: rtc-linux at googlegroups.com
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: linux-serial at vger.kernel.org
> > Cc: linux-usb at vger.kernel.org
> > Cc: linux-fbdev at vger.kernel.org
> > ---
> > HI all,
> > 
> > 	If it's ok with everyone this will go via at91
> > 	with the patch serie than clean up the include/mach
> 
> Fine with me.
> 
> > 	For preparation to switch to arm multiarch kernel
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> (for the CAN related changes)

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

for input piece.

-- 
Dmitry
