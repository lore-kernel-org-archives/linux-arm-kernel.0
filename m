From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Nov 2010 22:58:44 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
Message-ID: <20101124215844.GC4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 07:42:31PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> 2010/11/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> ....
> > I usually prefer just using DEBUG_LL and put
> >
> > ? ? ? ?#ifdef CONFIG_DEBUG_LL
> > ? ? ? ? ? ? ? ?void printch(char);
> > ? ? ? ? ? ? ? ?printch(c);
> > ? ? ? ?#endif
> >
> > into emit_log_char. ?But I think that's only because I don't know how to
> > use early printk properly. ?(You might need an additional kernel
> > parameter?!)
> 
> Thanks. I see that the kernel crashes at sdma_get_firmware.
> 
> Will try to build a firmware using Sascha's SDMA utility.
Maybe there is a fix needed to make the machine boot even if no firmware
is found?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
