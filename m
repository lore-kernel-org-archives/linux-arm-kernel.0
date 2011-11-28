From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 28 Nov 2011 22:08:06 +0800
Subject: [PATCH 4/5] regulator: mc13892: add device tree probe support
In-Reply-To: <20111128133545.GF8275@opensource.wolfsonmicro.com>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
 <1322487439-27254-5-git-send-email-shawn.guo@linaro.org>
 <20111128133545.GF8275@opensource.wolfsonmicro.com>
Message-ID: <20111128140805.GB19754@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 01:35:45PM +0000, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 09:37:18PM +0800, Shawn Guo wrote:
> > It adds device tree probe support for mc13892-regulator driver.
> 
> You haven't documented the binding here at all.  Documentation is
> mandatory for all device tree bindings.

It reminds me that I should add binding document for mc13xxx mfd
driver.  However, there is basically nothing to add for
mc13892-regulator binding, as it has nothing specific but all that
have already documented in
Documentation/devicetree/bindings/regulator/regulator.txt.

-- 
Regards,
Shawn
