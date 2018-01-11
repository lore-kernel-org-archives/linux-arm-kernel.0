From: bp@alien8.de (Borislav Petkov)
Date: Thu, 11 Jan 2018 20:28:38 +0100
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
In-Reply-To: <121880e53de2408f9699bb04b9caf2b9@svr-chch-ex1.atlnz.lc>
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
 <121880e53de2408f9699bb04b9caf2b9@svr-chch-ex1.atlnz.lc>
Message-ID: <20180111192838.qz54r5aal4m6bsyg@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 09:54:29PM +0000, Chris Packham wrote:
> Do you have any preference for which option to take? I'm leaning towards 
> MACH_MVEBU_V7.

With my layman attempts at looking at ARM Kconfig organization, this
makes sense to me too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
