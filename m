From: bp@alien8.de (Borislav Petkov)
Date: Thu, 11 Jan 2018 20:31:21 +0100
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
In-Reply-To: <2b8d9facf0ee4110af4815d024693652@svr-chch-ex1.atlnz.lc>
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
 <2b8d9facf0ee4110af4815d024693652@svr-chch-ex1.atlnz.lc>
Message-ID: <20180111193121.cbausyodzucdgu7v@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:05:48PM +0000, Chris Packham wrote:
> Would you suggest dropping "armada_xp" altogether or just shortening to 
> "axp"? What about dropping "edac" as well?

Whatever you prefer. And yes, my personal preference is short symbols so
I'd drop "edac" too.

I mean, we know it is "edac" - the whole driver is edac :-) and those
functions are static so their name being unique makes only partial sense
in stack traces and if the compiler hasn't inlined them...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
