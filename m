From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 00:57:09 +0000
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111220005708.GM2860@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:15:56PM +0800, Shawn Guo wrote:

> +Sub-nodes:
> +- regulators : Contain the regulator nodes.  The name of regulator node
> +  is being used by mc13xxx regulator driver to find the correct relator
> +  device.

Reading this I'm not clear what the name of the node is, or what the
valid node names are.

> +			sw1_reg: mc13892__sw1 {

The examples don't really elucidate this either (and the __ is rather
odd).
