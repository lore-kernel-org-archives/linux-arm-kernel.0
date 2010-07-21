From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Jul 2010 10:20:43 +0200
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <20100708070826.GB21565@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<20100705141344.GA25407@pengutronix.de>
	<20100707144521.GB10470@pengutronix.de>
	<alpine.LFD.2.00.1007071150390.6020@xanadu.home>
	<20100708070826.GB21565@pengutronix.de>
Message-ID: <20100721082043.GA23853@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Jul 08, 2010 at 09:08:26AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Jul 07, 2010 at 11:54:14AM -0400, Nicolas Pitre wrote:
> > On Wed, 7 Jul 2010, Uwe Kleine-K?nig wrote:
> > > On Mon, Jul 05, 2010 at 04:13:44PM +0200, Uwe Kleine-K?nig wrote:
> > > > this series is a merge between Eric's and my patches that we did to
> > > > clean up the early boot code.  It doesn't contain runtime physoffset
> > > > support for now, but I plan to pick that up later.
> > > 
> > > I added Nicolas' Acks to my tree and dropped the one patch he objected.
> > > 
> > > Are you willing to pull these now?
> > 
> > FWIW, I'm fine with Russell pulling this into his tree for the next 
> > merge window.  Maybe you could just resend an official pull request with 
> > the updated info.
> OK, I thought it similar enough to the original request, but if it helps
> I can do that:
> 
> The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:
> 
>   Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting
> 
> Eric Miao (2):
>       ARM: Remove unused PARAMS_PHYS from arch/arm/boot/compressed
>       Auto calculate ZRELADDR and provide option for exceptions
> 
> Uwe Kleine-K?nig (8):
>       ARM: zImage: don't hard code the stack size twice
>       ARM: zImage: some comments for __armv3_mpu_cache_on
>       ARM: zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
>       ARM: zImage: fix comments for cache_on, cache_off and cache_clean_flush
>       ARM: zImage: annotate debug functions about corrupted registers
>       ARM: remove bit-rotten STANDALONE_DEBUG for decompressor
>       ARM: zImage: don't define unused symbol initrd_phys
>       ARM: deprecate support for old way to pass kernel parameters
I added an ARM: prefix to Eric's second commit, other than that the
branch is unchanged.  Do you pull for .36-rc1?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
