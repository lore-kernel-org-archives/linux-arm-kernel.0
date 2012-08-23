From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 23 Aug 2012 15:15:04 +0800
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use
 imx-syscon to access anatop register
In-Reply-To: <20120822155953.GQ7995@opensource.wolfsonmicro.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-5-git-send-email-b29396@freescale.com>
 <20120822155953.GQ7995@opensource.wolfsonmicro.com>
Message-ID: <20120823071503.GF10057@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 11:59:53PM +0800, Mark Brown wrote:
> On Wed, Aug 22, 2012 at 03:18:45PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Using standard imx syscon API to access anatop register.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
Thanks

> With the conversion to regmap it'd also be good to convert the driver to
> use the regmap helper functions for enable and voltage operations if
> possible.

The anatop-regulator driver only implements set_voltage_sel/get_voltage_sel
which i have already converted, what do you mean others like
'for enable and voltage operations' i should also convert?

Regards
Dong Aisheng
