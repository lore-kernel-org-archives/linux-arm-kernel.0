From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2018 22:01:20 -0300
Subject: [PATCH 2/3] ARM: dts: imx31: add device tree description of basic
 controllers
In-Reply-To: <20180703192934.6080-3-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
 <20180703192934.6080-3-vz@mleia.com>
Message-ID: <CAOMZO5AW6QryKAjcG_kE011G1anLD=-EaJFhAaWzaqbf3aKNUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 4:29 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> The change adds a number of basic peripherals found on i.MX31 SoC:
> * GPIO controllers,
> * I2C master controllers,
> * SPI master controllers,
> * ATA controller,
> * SDHC controllers,
> * RTC, watchdog and PWM contollers,
> * SDMA,
> * IRAM,
> * NAND and WEIM controllers on EMI.
>
> The added controller devices were tested on Freescale i.MX31 powered
> LogicPD Lite SoM and baseboard.
>
> DMA functionality was tested on SDHC and SPI controllers so far,
> thus dmas properties are added to those device nodes only.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
