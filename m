From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 12 Mar 2013 21:00:30 +0200
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Message-ID: <20130312190030.GB8798@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 12, 2013 at 04:40:19PM +0000, Paul Walmsley wrote:
> * 2420N800: powers down 30 seconds after boot
>   - Presumably due to missing CBUS patches for watchdog control
>   - http://lkml.org/lkml/2012/9/3/265
>   - http://marc.info/?l=linux-omap&m=135274739624125&w=2
>   - http://marc.info/?l=linux-omap&m=135664195831104&w=2
>   - Should be working in v3.9-rc1 when CONFIG_RETU_WATCHDOG=y ?

Yes, you need also CONFIG_I2C_CBUS_GPIO and CONFIG_MFD_RETU.

A.
