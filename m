From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 01:07:35 +0900
Subject: [PATCH v2] ARM: S3C24XX: add devicetree support for smdk2416
In-Reply-To: <201304131606.48278.heiko@sntech.de>
References: <201304131606.48278.heiko@sntech.de>
Message-ID: <519A4A47.1010300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/13 23:06, Heiko St?bner wrote:
> Definitions in s3c24xx.dtsi are usable for all s3c24xx SoCs, but some
> need to be extended with proper compatible properties, as can be seen
> in s3c2416.dtsi .
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> Reviewed-by: Sylwester Nawrocki<s.nawrocki@samsung.com>

Looks good to me, applied, thanks.

- Kukjin

> ---
> changes since v1:
>    fix compatible property of default irq controller
>    (the correct one is samsung,s3c2410-irq)
>
>   arch/arm/boot/dts/Makefile              |    1 +
>   arch/arm/boot/dts/s3c2416-pinctrl.dtsi  |  173 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/s3c2416-smdk2416.dts  |   72 +++++++++++++
>   arch/arm/boot/dts/s3c2416.dtsi          |   79 ++++++++++++++
>   arch/arm/boot/dts/s3c24xx.dtsi          |   92 ++++++++++++++++
>   arch/arm/mach-s3c24xx/Kconfig           |   12 ++
>   arch/arm/mach-s3c24xx/Makefile          |    1 +
>   arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   91 ++++++++++++++++
>   8 files changed, 521 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/boot/dts/s3c2416-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/s3c2416-smdk2416.dts
>   create mode 100644 arch/arm/boot/dts/s3c2416.dtsi
>   create mode 100644 arch/arm/boot/dts/s3c24xx.dtsi
>   create mode 100644 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
