From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 15:36:38 +0000
Subject: [PATCH v2 1/4] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111202153637.GY8245@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 05:21:05PM +0800, Shawn Guo wrote:

> +Sub-nodes:
> +- regulators : Contain the regulator nodes.  The bindings details of individual
> +  regulator node can be found in:
> +  Documentation/devicetree/bindings/regulator/regulator.txt

How does the driver figure out which regulators map onto which subnodes?
