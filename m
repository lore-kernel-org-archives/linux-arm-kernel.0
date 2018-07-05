From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 5 Jul 2018 22:09:27 +0300
Subject: [PATCH 2/3] ARM: dts: imx31: add device tree description of basic
 controllers
In-Reply-To: <CAOMZO5AW6QryKAjcG_kE011G1anLD=-EaJFhAaWzaqbf3aKNUQ@mail.gmail.com>
References: <20180703192934.6080-1-vz@mleia.com>
 <20180703192934.6080-3-vz@mleia.com>
 <CAOMZO5AW6QryKAjcG_kE011G1anLD=-EaJFhAaWzaqbf3aKNUQ@mail.gmail.com>
Message-ID: <430434fe-da1d-ffd9-0b54-a0c7d63c6284@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 07/05/2018 04:01 AM, Fabio Estevam wrote:
> On Tue, Jul 3, 2018 at 4:29 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>> The change adds a number of basic peripherals found on i.MX31 SoC:
>> * GPIO controllers,
>> * I2C master controllers,
>> * SPI master controllers,
>> * ATA controller,
>> * SDHC controllers,
>> * RTC, watchdog and PWM contollers,
>> * SDMA,
>> * IRAM,
>> * NAND and WEIM controllers on EMI.
>>
>> The added controller devices were tested on Freescale i.MX31 powered
>> LogicPD Lite SoM and baseboard.
>>
>> DMA functionality was tested on SDHC and SPI controllers so far,
>> thus dmas properties are added to those device nodes only.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

thank you for review, please note that I've just sent v2 with a couple
of minor fixes as a reply to v1 2/3, I hope that I didn't introduce
a mess to the series.

And again I hope that a number of missing SoC specific compatibles
could be added to the documentation later on, at the moment generic
variants are good enough to run the corresponding drivers.

--
Best wishes,
Vladimir
