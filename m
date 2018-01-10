From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Jan 2018 23:05:48 +0000
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
Message-ID: <2b8d9facf0ee4110af4815d024693652@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 17/11/17 08:32, Borislav Petkov wrote:
> That struct name is too long. So long that it makes you break parameter
> names below.
> 
> For example, you don't need that lenghty prefix "armada_xp_mc_edac"
> prepended to static symbols. Same for the function names below.

Would you suggest dropping "armada_xp" altogether or just shortening to 
"axp"? What about dropping "edac" as well?
