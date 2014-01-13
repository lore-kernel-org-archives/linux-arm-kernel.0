From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 12:28:26 +0800
Subject: [PATCHv10][ 3/3] ARM: imx_v6_v7_defconfig: Enable some drivers
 used on the cpuimx35.
In-Reply-To: <1389368441-26310-3-git-send-email-denis@eukrea.com>
References: <1389368441-26310-1-git-send-email-denis@eukrea.com>
 <1389368441-26310-3-git-send-email-denis@eukrea.com>
Message-ID: <20140113042824.GL23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 04:40:41PM +0100, Denis Carikli wrote:
> The eukrea cpuimx35 has a pcf8563 RTC and a LCD gpio regulator.
> 
> We enable the respective drivers in order to be able to use theses
>   features with this configuration.
> 
> We also enabled the i.MX35 DT support because the cpuimx35 has now DT support.

It does not include the change of enabling i.MX35 DT support.  Actually,
the change has been made by patch 'ARM: imx_v6_v7_defconfig: Select MX35
and MX50 device tree support' from Fabio.

So I dropped the line and applied the patch.  Thanks.

Shawn

> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
