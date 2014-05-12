From: mark.hambleton@broadcom.com (Mark Hambleton)
Date: Mon, 12 May 2014 14:09:06 +0000
Subject: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
In-Reply-To: <20140512121729.GC12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <536D0AF4.1040705@arm.com> <20140509175005.GT12304@sirena.org.uk>
 <536D2533.6050100@arm.com> <20140509192921.GY12304@sirena.org.uk>
 <5370877C.40409@arm.com> <20140512121729.GC12304@sirena.org.uk>
Message-ID: <D00A5DFD97C44C4D820FC3A847C5D57507406990@IRVEXCHMB14.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This all gets a bit circular though - the more patches people have to
> carry to make upstream useful to them less useful working with upstream
> seems to them, meaning the devices are less likely to appear upstream at
> all at least in any sort of complete form.  One out of tree patch being
> required isn't going to be a deal breaker by itself but they all add up
> to a perception that upstream isn't useful.
> 
> There's definitely some taste considerations with how far you go to
> cater for such systems - in this case I'd say it's just tweaking Kconfig
> to allow people to use code that's already present rather than adding
> really new code (there's the stubs but they're pretty insubstantial)
> which means upstream doesn't have to carry anything that wasn't there
> already.

Agree, with the original version of this patch I just put all the stubs in drivers/cpufreq/arm_big_little.h to get around needing to add files to arm64 (when it shouldn't need it). At least then the stubs were pretty local to the implementation and didn't require all of the ifdefs in the code (as Mark says that looks horrible).

Mark
