From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Tue, 09 Jan 2018 10:18:08 +0100
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
In-Reply-To: <2d257134ee344f128a80e5b17ca5c76f@svr-chch-ex1.atlnz.lc>
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <2d257134ee344f128a80e5b17ca5c76f@svr-chch-ex1.atlnz.lc>
Message-ID: <1515489488.5465.40.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, 2018-01-08 at 22:00 +0000, Chris Packham wrote:
> Hi Jan,
> 
> On 10/11/17 22:03, Jan Luebbe wrote:
> > Add support for the ECC functionality as found in the DDR RAM and
> > L2 cache controllers on the MV78230/MV78x60 SoCs. This driver has
> > been tested on the MV78460 (on a custom board with a DDR3 ECC
> > DIMM).
> > 
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> 
> What is the current state of this? I see there were some comments
> from Borislav that need addressing.
> 
> I've got my patches for Armada-380 and 98dx3236 ready. They're
> fairly minor so I might send them anyway just to get any feedback.
> They probably could be incorporated into a v4 series if you are
> willing to carry them.

This series is still on my todo list, but I currently don't have the
time to work on it (and probably also not in the next weeks). If you
have some spare time to pick it up and address Borislav's comments, I
wouldn't mind at all. ;)

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
