From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:53:08 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable useful configurations
 for Vybrid
In-Reply-To: <1455156498-29949-1-git-send-email-stefan@agner.ch>
References: <1455156498-29949-1-git-send-email-stefan@agner.ch>
Message-ID: <20160214075308.GO6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 06:08:18PM -0800, Stefan Agner wrote:
> Enable configuration options useful for Vybrid:
> - NFC NAND driver
> - USB dual-role controller support
> - FTM PWM driver
> - DSPI SPI driver
> - Colibri VF50 Touchscreen support.
> 
> Beside that, enable useful configurations such as IIO hwmon support
> (used in i.MX 23/28, patch pending for Vybrid), PWM LED support and
> CPU idle support.
> 
> Regenerated config using savedefconfig (which removes some configs
> which are now enabled by default).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
