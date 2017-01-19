From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 19 Jan 2017 17:41:29 +0100
Subject: [PATCH 1/3] PCI: imx6: Fix a typo in error message
In-Reply-To: <20170119163631.10668-2-andrew.smirnov@gmail.com>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
 <20170119163631.10668-2-andrew.smirnov@gmail.com>
Message-ID: <1484844089.24339.41.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 19.01.2017, 08:36 -0800 schrieb Andrey Smirnov:
> Cc: yurovsky at gmail.com
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/host/pci-imx6.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c8cefb0..50a1291 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -678,8 +678,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
>  							   "pcie_inbound_axi");
>  		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> -			dev_err(dev,
> -				"pcie_incbound_axi clock missing or invalid\n");
> +			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
>  			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
>  		}
>  	}
