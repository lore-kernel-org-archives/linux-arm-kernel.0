From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Aug 2012 17:54:32 +0100
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
Message-ID: <20120815165431.GF15365@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 04:47:02PM +0000, AnilKumar, Chimata wrote:
> On Wed, Aug 15, 2012 at 18:23:39, Mark Brown wrote:

> > If you have all these unrelated supplies in the system then your device
> > tree should accurately reflect that.  However this would be a very

> In that case I have to add all these fixed regulators.

Why?  You then immediately go on to say...

> > unusual hardware design.  Usually there would be a very small set of
> > system supply rails, frequently only one.

> In case of AM335X-EVM one dedicated supply (5v) feeding to all the input
> supplies (vcc1-7 and vccio) of the regulators.

...that they all map onto the same physical supply?
