From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jun 2014 12:59:42 +0800
Subject: [PATCH] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: unbreak esdhc.
In-Reply-To: <1403096216-21292-1-git-send-email-denis@eukrea.com>
References: <1403096216-21292-1-git-send-email-denis@eukrea.com>
Message-ID: <20140621045941.GD6818@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 02:56:56PM +0200, Denis Carikli wrote:
> The following commit:
> 89d7e5c mmc: sdhci-esdhc-imx: add runtime pm support
> has the effect of also disabling the hardware card detect
> in runtime pm.
> 
> We switch to GPIO based detection to avoid this issue.
> 
> This patch is based on:
> ARM: dts: imx51-babbage: Fix esdhc setup
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied, thanks.
