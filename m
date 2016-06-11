From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 14:48:26 +0800
Subject: [PATCH 0/3] ARM: dts: Use generic uart-has-rtscts DT property
In-Reply-To: <1464705112-21609-1-git-send-email-geert+renesas@glider.be>
References: <1464705112-21609-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160611064826.GC20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 04:31:49PM +0200, Geert Uytterhoeven wrote:
> 	Hi Shawn, Sascha, Barry,
> 
> As of v4.7-rc1, the Freescale MXS AUART and IMX UART drivers, and the
> SiRF UART driver, recognize the generic "uart-has-rtscts" DT property,
> deprecating the vendor-specific "<vendor>,uart-has-rtscts" DT
> properties.  This series updates all DTS files to replace the latter by
> the former.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (3):
>   ARM: dts: imx28: Use generic uart-has-rtscts DT property
>   ARM: dts: imx: Use generic uart-has-rtscts DT property

Applied these two, thanks.
