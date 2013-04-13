From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 13 Apr 2013 11:40:39 +0200
Subject: [PATCH] ARM: S3C24XX: add devicetree support for smdk2416
In-Reply-To: <201304130153.11653.heiko@sntech.de>
References: <201304130153.11653.heiko@sntech.de>
Message-ID: <51692817.7060501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2013 01:53 AM, Heiko St?bner wrote:
> Definitions in s3c24xx.dtsi are usable for all s3c24xx SoCs, but some
> need to be extended with proper compatible properties, as can be seen
> in s3c2416.dtsi .
>
> Signed-off-by: Heiko Stuebner<heiko@sntech.de>

Well done, thanks!

Would be nice to see it in 3.10.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> ---
> This patch depends on the not yet merged s3c24xx pinctrl support and
> the samsung-time muliplatform support.
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
