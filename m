From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Jul 2011 11:36:30 -0700
Subject: [PATCH] ARM: Migrate to asm-generic wrapper support
In-Reply-To: <m31uxje8o4.fsf@intrepid.localdomain>
References: <1311204225-13169-1-git-send-email-sboyd@codeaurora.org>	<20110720232819.GC20310@n2100.arm.linux.org.uk>	<4E27667D.9060200@codeaurora.org>
	<m31uxje8o4.fsf@intrepid.localdomain>
Message-ID: <4E2871AE.8030603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2011 12:27 PM, Krzysztof Halasa wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
>
>> With d8ecc5c (kbuild: asm-generic support, 2011-04-27) we can
>> remove a handful of asm-generic wrappers in ARM code. Since the
>> generic version of sizes.h doesn't contain SZ_48M, we replace
>> the 3 users of SZ_48M with the equivalent SZ_32M + SZ_16M.
> Perhaps simply adding SZ_48M to the generic version is better. Can live
> with either.

This was simpler (1 patch, 1 maintainer). Is that an ack?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
