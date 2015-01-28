From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 28 Jan 2015 01:33:16 +0000
Subject: [PATCH 0/3] iio: adc: vf610: respect ADC clocking limitations
In-Reply-To: <1421769723-28677-1-git-send-email-stefan@agner.ch>
References: <1421769723-28677-1-git-send-email-stefan@agner.ch>
Message-ID: <BLUPR03MB37366EC9DAB3A4B0A16E72BF5330@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch> Sent: Wednesday, January 21, 2015 12:02 AM
> To: jic23 at kernel.org
> Cc: shawn.guo at linaro.org; Duan Fugang-B38611; maitysanchayan at gmail.com;
> linux-iio at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; stefan at agner.ch
> Subject: [PATCH 0/3] iio: adc: vf610: respect ADC clocking limitations
> 
> Respect ADC clocking limitations which lead to bogous reading on 500MHz
> clocked Vybrid SoC's. Additionally, also implement a sysfs-property to
> configure the conversion mode available in this ADC peripherial.
> 
> Stefan Agner (3):
>   iio: adc: vf610: use ADC clock within specification
>   iio: adc: vf610: implement configurable conversion modes
>   ARM: dts: add property for maximum ADC clock frequencies
> 
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
>  arch/arm/boot/dts/vfxxx.dtsi                       |   4 +
>  drivers/iio/adc/vf610_adc.c                        | 175
> +++++++++++++++++----
>  3 files changed, 156 insertions(+), 32 deletions(-)
> 
> --
> 2.2.2

The patch set are fine for me.

Acked-by: Fugang Duan <B38611@freescale.com>

Thanks. 
Fugang
