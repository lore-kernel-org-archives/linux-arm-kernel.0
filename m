From: fcooper@ti.com (Franklin Cooper Jr.)
Date: Fri, 3 Jun 2016 13:42:19 -0500
Subject: [PATCH 0/5] ARM:Keystone: Add pinmuxing support
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <5cc270d6-aec9-a1a8-597b-37c8413496a9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping on this series

On 04/27/2016 09:11 AM, Franklin S Cooper Jr wrote:
> Unlike most Keystone 2 devices, K2G supports pinmuxing of its pins. This
> patch series enables pinmuxing for Keystone 2 devices.
>
> Franklin S Cooper Jr (1):
>   ARM: keystone: defconfig: Enable PINCTRL SINGLE for Keystone 2
>
> Lokesh Vutla (3):
>   ARM: Keystone: Enable PINCTRL for Keystone ARCH
>   ARM: dts: keystone: Header file for pinctrl constants
>   ARM: dts: k2g-evm: Add pinmuxing for UART0
>
> Vitaly Andrianov (1):
>   ARM: dts: k2g: Add pinctrl support
>
>  arch/arm/boot/dts/keystone-k2g-evm.dts | 11 ++++++++++
>  arch/arm/boot/dts/keystone-k2g.dtsi    |  8 +++++++
>  arch/arm/configs/keystone_defconfig    |  1 +
>  arch/arm/mach-keystone/Kconfig         |  1 +
>  include/dt-bindings/pinctrl/keystone.h | 39 ++++++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/keystone.h
>
