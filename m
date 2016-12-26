From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Dec 2016 14:26:33 -0200
Subject: [PATCH v3 1/3] ARM: dts: imx6: Add Savageboard common file
In-Reply-To: <20161209010436.7994-2-woogyom.kim@gmail.com>
References: <20161209010436.7994-1-woogyom.kim@gmail.com>
 <20161209010436.7994-2-woogyom.kim@gmail.com>
Message-ID: <CAOMZO5CV3Dgzr-uV8fcp9xCPcwb_CfsvcgE4Onb9wjuK-MmDug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2016 at 11:04 PM, Milo Kim <woogyom.kim@gmail.com> wrote:
> * Memory
>   memblock for DDR3 1GB
>
> * Regulator
>   3.3V for panel and backlight.
>
> * Display
>   Enable HDMI and LVDS panel. Savageboard supports AVIC TM097TDH02 panel
>   which is compatible with Hannstar HSD100PXN1, so reuse it.
>
> * Clock
>   The commit d28be499c45e6 is applied to support LVDS and HDMI output
>   simultaneously.
>
> * Pinmux
>   eMMC, ethernet, HDMI, I2C, power button, PWM, SD card and UART.
>
> * Others
>   Enable ethernet, UART1 debug, USB host, USDHC3 for microSD card and
>   USDHC4 for built-in eMMC storage.
>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
