From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 8 Jan 2018 22:00:30 +0000
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
Message-ID: <2d257134ee344f128a80e5b17ca5c76f@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On 10/11/17 22:03, Jan Luebbe wrote:
> Add support for the ECC functionality as found in the DDR RAM and L2
> cache controllers on the MV78230/MV78x60 SoCs. This driver has been
> tested on the MV78460 (on a custom board with a DDR3 ECC DIMM).
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

What is the current state of this? I see there were some comments from 
Borislav that need addressing.

I've got my patches for Armada-380 and 98dx3236 ready. They're fairly 
minor so I might send them anyway just to get any feedback. They 
probably could be incorporated into a v4 series if you are willing to 
carry them.
