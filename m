From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Jan 2015 10:32:04 +0100
Subject: [PATCH v4 2/4] ARM: make mach-xyz/Makefile.boot optional for
 !ARCH_MULTIPLATFORM
In-Reply-To: <20131111193526.GA12278@quad.lixom.net>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131111193526.GA12278@quad.lixom.net>
Message-ID: <20150130093204.GB29856@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof, hello Russell,

On Mon, Nov 11, 2013 at 11:35:26AM -0800, Olof Johansson wrote:
> On Mon, Nov 04, 2013 at 12:00:51PM +0100, Uwe Kleine-K?nig wrote:
> > Makefile.boot is supposed to define zreladdr-y, params_phys-y and
> > initrd_phys-y. The first one is only needed in the absence of AUTO_ZRELADDR
> > and when building a zImage. The latters are only needed for bootp stuff.
> > So ignore errors on including Makefile.boot and error out in the targets
> > that need the corresponding settings.
> > 
> > This makes it unnecessary to create dummy Makefile.boot files.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> Please send it to Russell's patch tracker.
I did that and it waits for being applied there since November 2013.

Russell, is there a problem with the patch?

Having this patch would allow to get rid of
arch/arm/mach-efm32/Makefile.boot.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
