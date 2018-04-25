From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Apr 2018 10:22:34 -0500
Subject: [PATCH] ARM: dts: imx6ull: add UART5 RTS input select register
In-Reply-To: <1524136779-13246-1-git-send-email-stefan.wahren@i2se.com>
References: <1524136779-13246-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20180425152234.xq2aq7c2732unfax@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 01:19:39PM +0200, Stefan Wahren wrote:
> The iMX6ULL UART5_RTS_B_DATA_SELECT_INPUT DAISY Register has some different
> bit definitions to that same register in the i.MX6UL.
> 
> The bits for the i.MX6UL:
> 
> 000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> 001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> 010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> 011 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> 100 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> 101 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
> 
> But for the i.MX6ULL:
> 
> 000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> 001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> 010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> 011 UART1_CTS_B_ALT9 ? Selecting Pad: UART1_CTS_B for Mode: ALT9
> 100 UART1_RTS_B_ALT9 ? Selecting Pad: UART1_RTS_B for Mode: ALT9
> 101 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> 110 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> 111 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
