From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Jan 2013 09:27:12 +0100
Subject: [PATCH V2  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130116145749.24249.678.stgit@localhost>
References: <20130116145749.24249.678.stgit@localhost>
Message-ID: <20130122082712.GJ1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 03:57:49PM +0100, Martin Fuzzey wrote:
> W1: Support onewire master on i.MX53
> 	* Add device tree and pinctrl support to the MXC master driver
> 	* Convert to use devm_
> 	* Add i.MX53 clocks
> 	* Add i.MX53 device tree entries
> 
> Changes since V1
> * Applied comments from Sascha Hauer:
> 	* Move patch converting driver to devm_ before the one adding devm_ based pinctrl
> 	* Fix existing unbalanced clk_prepare_enable/clk_disable_unprepare
> 	in probe error path
> 
> * Place DT patch last since it includes pinctrls for driver.

This looks good now.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

You might have to send this again in two series, one for the w1
maintainer and one for arm-soc. Both series should be sufficiently
orthogonal.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
