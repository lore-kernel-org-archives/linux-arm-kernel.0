From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 14 Jun 2013 10:20:43 +0000
Subject: [PATCH v2 0/4] GPIO DT support for da850
In-Reply-To: <1371203020-15092-1-git-send-email-avinashphilip@ti.com>
References: <1371203020-15092-1-git-send-email-avinashphilip@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EADAFCF@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 15:13:36, Philip, Avinash wrote:
> With conversion of GPIO davinci driver to platform driver, gpio-davinci driver
> can support DT boot.
> This patch series
> - adds dt binding support for gpio-davinci.
> - da850 dt support goio.
> 
> This patch series is based on Linux 3.10-rc4 and is availabel at [1].
> 
> 1. https://github.com/avinashphilip/am335x_linux/tree/linux_davinci_v3.10_soc_gpio_v310-rc4


This patch series has dependency on [PATCH v2 0/7] Convert GPIO Davinci to platform driver

https://lkml.org/lkml/2013/6/14/120

Thanks
Avinash

> 
> KV Sujith (3):
>   gpio: davinci: DT changes for driver
>   ARM: davinci: da850: add GPIO DT entries
>   ARM: davinci: da850 evm: add GPIO DT data
> 
> Philip Avinash (1):
>   ARM: davinci: da850: Use #include for all device trees
> 
>  .../devicetree/bindings/gpio/gpio-davinci.txt      |   32 +++++++++++
>  arch/arm/boot/dts/da850-enbw-cmc.dts               |    2 +-
>  arch/arm/boot/dts/da850-evm.dts                    |   21 +++++++-
>  arch/arm/boot/dts/da850.dtsi                       |   17 +++++-
>  drivers/gpio/gpio-davinci.c                        |   57 ++++++++++++++++++--
>  5 files changed, 123 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> 
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
