From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 May 2015 15:18:27 -0300
Subject: [PATCH v2] ARM: dts: Gateworks GW5510 support (i.MX6)
In-Reply-To: <1431013080-13536-1-git-send-email-tharvey@gateworks.com>
References: <1431013080-13536-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5B6qFzp7sAtycF_BuzPfsp=PxF0+OG3ZjbHepp0AFnrpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 7, 2015 at 12:38 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Add support for the Gateworks GW5510 board featuring:
>  * i.MX6 SoC
>  * up to 512MB DDR3
>  * up to 2GB NAND flash
>  * 1x miniPCIe socket (with USB)
>  * HDMI out (micro-HDMI)
>  * HDMI in (micro-HDMI) (currently supported by only vendor kernel)
>  * TTL level I/O (supported by GW16111 breakout board):
>   * I2C
>   * 2x UART
>   * CAN
>   * 2x DIO (GPIO/PWM)
>   * USB OTG
>
> For more details see:
>  http://www.gateworks.com/product/item/ventana-gw5510-single-board-computer
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
