From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 13:27:13 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Configure the ECSPI1 chip
 select pin
In-Reply-To: <1400097235-23025-1-git-send-email-festevam@gmail.com>
References: <1400097235-23025-1-git-send-email-festevam@gmail.com>
Message-ID: <20140519052712.GI10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 04:53:55PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> GPIO4_9 is used as ECSPI1 chip select and it needs to be configured as GPIO.
> 
> Configure the pin functionality explicitly in the dts file instead of relying
> on the fact that it comes configured as GPIO from POR or from the bootloader.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
