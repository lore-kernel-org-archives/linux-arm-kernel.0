From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 May 2011 21:26:13 +0200
Subject: [PATCH v2 2/7] mmc: sdhci: eliminate sdhci_of_host and
	sdhci_of_data
In-Reply-To: <1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110524192613.GA25727@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:53PM +0800, Shawn Guo wrote:
> The patch migrates the use of sdhci_of_host and sdhci_of_data to
> sdhci_pltfm_host and sdhci_pltfm_data, so that the former pair can
> be eliminated.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

We might be able to get rid of the migrated entries in sdhci-pltfm.h, but this
is a task for later IMO.

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110524/8fee7548/attachment.sig>
