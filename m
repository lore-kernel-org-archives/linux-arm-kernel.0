From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 21 Jul 2011 21:27:23 +0200
Subject: [PATCH] ARM: Migrate to asm-generic wrapper support
In-Reply-To: <4E27667D.9060200@codeaurora.org> (Stephen Boyd's message of
	"Wed, 20 Jul 2011 16:36:29 -0700")
References: <1311204225-13169-1-git-send-email-sboyd@codeaurora.org>
	<20110720232819.GC20310@n2100.arm.linux.org.uk>
	<4E27667D.9060200@codeaurora.org>
Message-ID: <m31uxje8o4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> With d8ecc5c (kbuild: asm-generic support, 2011-04-27) we can
> remove a handful of asm-generic wrappers in ARM code. Since the
> generic version of sizes.h doesn't contain SZ_48M, we replace
> the 3 users of SZ_48M with the equivalent SZ_32M + SZ_16M.

Perhaps simply adding SZ_48M to the generic version is better. Can live
with either.
-- 
Krzysztof Halasa
