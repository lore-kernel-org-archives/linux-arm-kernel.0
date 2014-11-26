From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 26 Nov 2014 16:56:27 +0800
Subject: [PATCH v2 0/2] ARM: hip04: add GPIO support
In-Reply-To: <1416984212-619-1-git-send-email-wangzhou.bry@gmail.com>
References: <1416984212-619-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <CAN1soZySQjz42Vq-Rer-iC5tL69dXY93cJHqBXzg4eL6nPsB2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 2:43 PM, Zhou Wang <wangzhou.bry@gmail.com> wrote:
> This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
> synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
> corresponding dts.
>
> Change in v2:
> - Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig
>
> Zhou Wang (2):
>   ARM: hip04: set ARCH_NR_GPIO to 128
>   ARM: dts: hip04: add GPIO pieces
>
>  arch/arm/Kconfig             |    1 +
>  arch/arm/boot/dts/hip04.dtsi |   75 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-hisi/Kconfig   |    1 +
>  3 files changed, 77 insertions(+)
>
> --
> 1.7.9.5
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
