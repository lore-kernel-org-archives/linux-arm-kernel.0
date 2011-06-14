From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 14 Jun 2011 14:48:42 +0800
Subject: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
	support for mx5
In-Reply-To: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110614064841.GB30295@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
> The card-present polling within sdhci based driver is very expensive
> in terms of the impact to system performance.  We observe a few
> system performance issues from Freescale and Linaro on mx5 platforms,
> which have been proved card polling related.
> 
> The patch set extends the current sdhci-esdhc-imx card_detect and
> write_protect support to cover mx5 platforms, and solves above
> performance issues.
> 
> Shawn Guo (4):
>       mmc: sdhci: fix interrupt storm from card detection
>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
> 
Hi Arnaud,

Any chance to play with it yet?

Hi Wolfram,

Any comment?

-- 
Regards,
Shawn
