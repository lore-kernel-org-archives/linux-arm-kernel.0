From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 23 Jul 2014 21:58:31 +0200
Subject: [PATCH 1/3] ARM: exynos: remove unused <mach/memory.h>
In-Reply-To: <CAOesGMgA0fc0_8JOOE01y=UKv-eAZuWiAkAKHG5iam0Zkhp9TA@mail.gmail.com>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140722075138.GB28538@pengutronix.de>
 <CAOesGMgA0fc0_8JOOE01y=UKv-eAZuWiAkAKHG5iam0Zkhp9TA@mail.gmail.com>
Message-ID: <20140723195831.GF7636@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 22, 2014 at 09:14:33AM -0700, Olof Johansson wrote:
> > Patch 2 (v2!)
> >
> >         ARM: remove remaining definitions of PLAT_PHYS_OFFSET from <mach/memory.h>
> >
> > touches several arch/arm/mach-*/include/mach/memory.h and
> > arch/arm/Kconfig. armsoc? Russell?
> 
> This can go through either, but Russell has already reviewed it once
> so send it to his patch tracker.
> 
> > Patch 3 fixes a warning regarding nommu and touches the Kconfig entry
> > for Integrator and Renesas (non-multiplatform). armsoc?
> 
> Don't know without seeing the patch. What's the patch subject so I can find it?
I talked to Olof on irc. I sent patches 2 and 3 to the patch tracker as

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8112/1

and

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8113/1

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
