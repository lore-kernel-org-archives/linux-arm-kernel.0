From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 22 Jul 2011 18:28:18 +0200
Subject: [PATCH] ARM: Migrate to asm-generic wrapper support
In-Reply-To: <4E2871AE.8030603@codeaurora.org> (Stephen Boyd's message of
	"Thu, 21 Jul 2011 11:36:30 -0700")
References: <1311204225-13169-1-git-send-email-sboyd@codeaurora.org>
	<20110720232819.GC20310@n2100.arm.linux.org.uk>
	<4E27667D.9060200@codeaurora.org>
	<m31uxje8o4.fsf@intrepid.localdomain>
	<4E2871AE.8030603@codeaurora.org>
Message-ID: <m3d3h25lgd.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

>>> With d8ecc5c (kbuild: asm-generic support, 2011-04-27) we can
>>> remove a handful of asm-generic wrappers in ARM code. Since the
>>> generic version of sizes.h doesn't contain SZ_48M, we replace
>>> the 3 users of SZ_48M with the equivalent SZ_32M + SZ_16M.
>> Perhaps simply adding SZ_48M to the generic version is better. Can live
>> with either.
>
> This was simpler (1 patch, 1 maintainer). Is that an ack?

Sure, Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
