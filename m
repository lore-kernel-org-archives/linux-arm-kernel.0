From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 13:34:38 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx6dl-wandboard: Add SDHC1 and SDHC2
 ports
In-Reply-To: <1373489419-20893-1-git-send-email-festevam@gmail.com>
References: <1373489419-20893-1-git-send-email-festevam@gmail.com>
Message-ID: <20130712053436.GB25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 05:50:18PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Wandboard has a SD card slot on the baseboard connected to SDHC1 and a
> BCM4329 (Wifi + Bluetooth chip) connected to SDHC2.
> 
> Add support for these ports.
> 
> While at it, provide the card detect gpio on SDHC3.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Fabio,

I did some tweaking on pin groups definition in DTS, so that we do not
have too much maintenance burden to keep the groups aligned between
imx6q and imx6dl.  Can you please rebase your patch on the latest imx/dt
branch?  Also please separate soc changes and board changes into
different patches.

Shawn
