From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Jan 2016 15:15:22 +0100
Subject: [PATCH v2 2/2] ARM: tegra: Add high speed UARTs to Jetson TK1
 device tree
In-Reply-To: <1453827558-10954-3-git-send-email-ralf@ramses-pyramidenbau.de>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <1453827558-10954-3-git-send-email-ralf@ramses-pyramidenbau.de>
Message-ID: <20160127141522.GB21779@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 05:59:18PM +0100, Ralf Ramsauer wrote:
> This patch enables the APB DMA high speed UARTs of the Jetson TK1. So
> far, they were only enabled in NVidia's official BSP.
> 
> Those additional UARTs are exposed on the expansion connector J3A2:
> 
>  UART1:
>   Pin 41: BR_UART1_TXD
>   Pin 44: BR_UART1_RXD
> 
>  UART2:
>   Pin 65: UART2_RXD
>   Pin 68: UART2_TXD
>   Pin 71: UART2_CTS_L
>   Pin 74: UART2_RTS_L
> 
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/a428cfe9/attachment-0001.sig>
