From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Mon, 17 Jul 2017 12:18:47 +0200
Subject: [PATCH 0/8] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <20170630145106.29820-1-jlu@pengutronix.de>
References: <20170630145106.29820-1-jlu@pengutronix.de>
Message-ID: <1500286727.6946.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

On Fri, 2017-06-30 at 16:50 +0200, Jan Luebbe wrote:
> This series adds drivers for the L2 cache and DDR RAM ECC functionality as
> found on the MV78230/MV78x60 SoCs. I've tested these changes with the MV78460
> (on a custom board with a DDR3 ECC DIMM).
> 
> Also contained in this series are an additional debugfs wrapper and devm_
> helpers for edac_mc_/edac_device_ allocation and registration, which make error
> handing and cleanup simpler.

before I send a v2 series (fixing the patch order and vendor prefix as
reported by Russell King), do you have comments on this series?

Patches 5-7 only touch drivers/edac. If you are fine the them as is,
maybe you could pick them from the current version and I'll drop them
from v2.

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
