From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 09:21:25 +0800
Subject: [PATCH v2 3/4] regulator: mc13892: add device tree probe support
In-Reply-To: <1322731268-12158-4-git-send-email-shawn.guo@linaro.org>
References: <1322731268-12158-1-git-send-email-shawn.guo@linaro.org>
 <1322731268-12158-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111212012124.GC9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Ping?

Regards,
Shawn

On Thu, Dec 01, 2011 at 05:21:07PM +0800, Shawn Guo wrote:
> It adds device tree probe support for mc13892-regulator driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> ---
>  drivers/regulator/mc13892-regulator.c      |   43 +++++++++++++++-----
>  drivers/regulator/mc13xxx-regulator-core.c |   57 ++++++++++++++++++++++++++++
>  drivers/regulator/mc13xxx.h                |   20 ++++++++++
>  include/linux/mfd/mc13xxx.h                |    1 +
>  4 files changed, 110 insertions(+), 11 deletions(-)
