From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 28 Feb 2010 11:34:44 +0100
Subject: arch/arm broken in next
In-Reply-To: <20100228101239.63de9eb6.sfr@canb.auug.org.au>
References: <20100227203345.GA5760@pengutronix.de>
	<20100228101239.63de9eb6.sfr@canb.auug.org.au>
Message-ID: <20100228103444.GC13987@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sun, Feb 28, 2010 at 10:12:39AM +1100, Stephen Rothwell wrote:
> On Sat, 27 Feb 2010 21:33:45 +0100 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> >
> > since
> > 
> > 	40464e5 (Merge remote branch 'samsung/next-samsung')
> > 
> > next is broken for arch/arm.  Our autobuilders fail with:
> > 
> > 	arch/arm/Kconfig:920: file 'arch/arm/mach-lh7a40x/Kconfig' is already sourced from 'arch/arm/Kconfig'
> > 
> > Both parents of 40464e5 only include the above file once.
> 
> Yeah, sorry about that.
No problem, thanks to you for doing the work to maintain next.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
