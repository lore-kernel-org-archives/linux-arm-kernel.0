From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Mar 2012 10:33:52 +0000
Subject: [PATCH v3 0/5] ARM: Initial support for Cortex-M3
In-Reply-To: <20120314101928.GA29474@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
Message-ID: <20120314103352.GA20899@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 10:19:28AM +0000, Uwe Kleine-K?nig wrote:
> this is the result of reworking Catalin's exception handling patch to
> stick to the current pt_regs layout. I extended it by two words to save
> the exception return value. (The 2nd word is unused and only to maintain
> stack alignment.)
> 
> Other than that only minor cleanups were done (some of them were
> suggested by Catalin in reply to my v2 series).
> 
> These patches are available at
> 
> 	git://git.pengutronix.de/git/ukl/linux.git cortexm3-for-rmk
> 
> basing on 3.3-rc7. There are some bits missing to allow a Cortex-M3 to
> boot. They are contained in the branch efm32 in the same repository
> together with support for the efm32 SoC if you're interested.
> The most important parts missing (apart from SoC specific stuff) are
> interrupt support and Makefile/Kconfig glue.
> 
> I'd be happy if these patches made it into 3.4-rc1.

That's pretty ambitious. Most maintainers (including Russell) closed
their trees by now. You can still aim for 3.5-rc1 and ideally have them
in -next a few weeks before (though only once Russell is fine with the
patches).

> Any constructive feedback welcome.

I'll go through the patches sometime next week.

-- 
Catalin
