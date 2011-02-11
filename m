From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 11 Feb 2011 13:07:39 +0300
Subject: [PATCH 2/5] mmc: sdhci-esdhc: broken card detection is not a
	default quirk
In-Reply-To: <20110210191821.GD2206@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
	<1297365291-1038-3-git-send-email-w.sang@pengutronix.de>
	<20110210191821.GD2206@pengutronix.de>
Message-ID: <20110211100739.GA8965@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 08:18:21PM +0100, Wolfram Sang wrote:
> 
> Adding Anton to Cc...
[...]
> >  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> > -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
> > +	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
> > +			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,

Minor nit: "|" should be on the previous line.

Otherwise,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
