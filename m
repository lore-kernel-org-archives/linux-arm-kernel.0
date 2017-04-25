From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Tue, 25 Apr 2017 06:09:54 +0000
Subject: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
In-Reply-To: <20170421070230.16582-1-colin.king@canonical.com>
References: <20170421070230.16582-1-colin.king@canonical.com>
Message-ID: <AM5PR0402MB28502178051215CE9C1EBAD08C1E0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Colin King [mailto:colin.king at canonical.com]
> Sent: Friday, April 21, 2017 3:03 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Subject: [PATCH] PCI: imx6: fix spelling mistake: "contol" -> "control"
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in dev_err message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Richard Zhu <hongxing.Zhu@nxp.com>

Best Regards
hongxing zhu
Email: hongxing.zhu at nxp.com

> ---
>  drivers/pci/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c index
> 102edcf1e261..129717ae5022 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -726,13 +726,13 @@ static int imx6_pcie_probe(struct platform_device
> *pdev)
>  		imx6_pcie->pciephy_reset = devm_reset_control_get(dev,
>  								  "pciephy");
>  		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> -			dev_err(dev, "Failed to get PCIEPHY reset contol\n");
> +			dev_err(dev, "Failed to get PCIEPHY reset control\n");
>  			return PTR_ERR(imx6_pcie->pciephy_reset);
>  		}
> 
>  		imx6_pcie->apps_reset = devm_reset_control_get(dev,
> "apps");
>  		if (IS_ERR(imx6_pcie->apps_reset)) {
> -			dev_err(dev, "Failed to get PCIE APPS reset
> contol\n");
> +			dev_err(dev, "Failed to get PCIE APPS reset
> control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
>  		break;
> --
> 2.11.0
