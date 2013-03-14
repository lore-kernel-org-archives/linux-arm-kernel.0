From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 14 Mar 2013 16:14:20 +0000 (UTC)
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <20130312190030.GB8798@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
 <20130312190030.GB8798@blackmetal.musicnaut.iki.fi>
Message-ID: <alpine.DEB.2.00.1303141558020.8075@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

On Tue, 12 Mar 2013, Aaro Koskinen wrote:

> On Tue, Mar 12, 2013 at 04:40:19PM +0000, Paul Walmsley wrote:
> > * 2420N800: powers down 30 seconds after boot
> >   - Presumably due to missing CBUS patches for watchdog control
> >   - http://lkml.org/lkml/2012/9/3/265
> >   - http://marc.info/?l=linux-omap&m=135274739624125&w=2
> >   - http://marc.info/?l=linux-omap&m=135664195831104&w=2
> >   - Should be working in v3.9-rc1 when CONFIG_RETU_WATCHDOG=y ?
> 
> Yes, you need also CONFIG_I2C_CBUS_GPIO and CONFIG_MFD_RETU.

Just enabled these two, and finally the N800 doesn't power down!  Nice 
work!  Amazing how exciting something like this can be :-)

This will be reflected in the v3.9-rc2 test log & the v3.9-rc1 log has now 
been fixed on the web.


- Paul
