From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 28 Aug 2017 12:07:33 +0300
Subject: [PATCH 5/5] MAINTAINERS: Add TI OMAP SDHCI Maintainer
In-Reply-To: <20170821074132.4622-6-kishon@ti.com>
References: <20170821074132.4622-1-kishon@ti.com>
 <20170821074132.4622-6-kishon@ti.com>
Message-ID: <e4617962-25dc-b286-85d6-c5a78c969428@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/17 10:41, Kishon Vijay Abraham I wrote:
> Add Maintainer for the TI OMAP SDHCI driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44cb004c765d..c9871351c16f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11777,6 +11777,12 @@ L:	linux-mmc at vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-spear.c
>  
> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) TI OMAP DRIVER
> +M:	Kishon Vijay Abraham I <kishon@ti.com>
> +L:	linux-mmc at vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/sdhci-omap.c
> +
>  SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
>  M:	Scott Bauer <scott.bauer@intel.com>
>  M:	Jonathan Derrick <jonathan.derrick@intel.com>
> 
