From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 13 Apr 2014 16:05:37 +0800
Subject: [PATCH] ARM: dts: imx6sl-evk: Add an entry for
 MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11
In-Reply-To: <1397218179-3533-1-git-send-email-festevam@gmail.com>
References: <1397218179-3533-1-git-send-email-festevam@gmail.com>
Message-ID: <20140413080535.GF24180@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 09:09:39AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> In case the bootloader has incorrectly configured the ALT mode of 
> MX6SL_PAD_ECSPI1_SS0 pad, we end up with the following probe error:
> 
> m25p80 spi0.0: found mr25h256, expected m25p32
> m25p80 spi0.0: mr25h256 (32 Kbytes)
> 
> In order to avoid this issue, add an entry for MX6SL_PAD_ECSPI1_SS0 pad, so
> that kernel configures the ECSPI chip select as GPIO functionality, which
> results in correct SPI NOR probe.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
