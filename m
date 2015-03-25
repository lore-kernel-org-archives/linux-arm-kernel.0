From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 25 Mar 2015 15:02:13 +0800
Subject: [RESEND PATCH v6 0/2] ARM: hip04: add GPIO support
In-Reply-To: <1427266665-226718-1-git-send-email-wangzhou1@hisilicon.com>
References: <1427266665-226718-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <CAD6h2NQQXgROxw4hLEH=OBw8WeEyr5by8ZDGEW7DQ1AuO0207Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2015 at 14:57, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
> synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
> corresponding dts. The default value of ARCH_NR_GPIOS is used to find gpio
> base here.
>
> Now this patchset is based on v4.0-rc5
>
> Change in v6:
> - Change E-mail address in signed-off-by to "wangzhou1 at hisilicon.com"
> Change in v5:
> - Base on v3.19-rc1
> - Just use default value of ARCH_NR_GPIOS to find gpio base. Remove the new
>   added patch(3/4) in v4.
> Change in v4:
> - Delete "default 128 if ARCH_HIP04" in arch/arm/Kconfig
> - add a new patch to support find GPIO base number in increasing order
> - add gpio-number-forward property in snps gpio binding doc
> Change in v3:
> - Move CONFIG_GPIO_DWAPB to hisi_defconfig
> - Add CONFIG_GPIOLIB, CONFIG_GPIO_SYSFS in hisi_defconfig
> Change in v2:
> - Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig
>
> Link for v4:
> - http://www.spinics.net/lists/arm-kernel/msg383883.html
> Link for v3:
> - http://www.spinics.net/lists/devicetree/msg60324.html
>
>
> Zhou Wang (2):
>   ARM: hip04: add GPIO configure in hisi_defconfig
>   ARM: dts: hip04: add GPIO pieces
>
>  arch/arm/boot/dts/hip04.dtsi    | 75 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/configs/hisi_defconfig |  1 +
>  2 files changed, 76 insertions(+)
>
> --
> 1.9.1
>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
