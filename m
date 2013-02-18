From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Feb 2013 14:12:03 +0800
Subject: [PATCH] ARM: dts: imx6q: add PMU
In-Reply-To: <1360937401-2442-1-git-send-email-dirk.behme@de.bosch.com>
References: <1360937401-2442-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130218061201.GL6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 03:10:01PM +0100, Dirk Behme wrote:
> Add ARM Cortex A9 Performance Monitor Unit (PMU) support.
> On i.MX6 a combined interrupt on hardware line #126 is used
> (i.MX6 TRM: Performance Unit interrupt).
> 
> For more details see Documentation/devicetree/bindings/arm/pmu.txt
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Queued for 3.10, thanks.
