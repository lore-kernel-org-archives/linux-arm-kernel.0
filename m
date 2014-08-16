From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 16 Aug 2014 11:46:48 -0500
Subject: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20140816164647.GA2858@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 9cfaab8152be..5a31c2b322ee 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -8,5 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
>  obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
>  obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
>  obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
> +obj-$(CONFIG_TI_CPSW_CTRL_MACID) += cpsw-ctrl-macid.o
>  obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
>  ti_cpsw-y := cpsw_ale.o cpsw.o cpts.o

Leftover from your last series?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/928038f0/attachment.sig>
