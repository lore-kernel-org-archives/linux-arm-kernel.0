From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 3 Jul 2015 19:10:18 +0800
Subject: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
In-Reply-To: <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150703111017.GA17553@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 04:50:40PM +0800, Haibo Chen wrote:
> @@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  
>  	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
>  
> +	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
> +

Where is the binding doc for this device tree property?

Shawn
