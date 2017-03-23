From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Mar 2017 17:43:45 +0100
Subject: [PATCH 0/3] Fix and improve USB3 support on Armada 37xx
In-Reply-To: <20170308173315.28512-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 8 Mar 2017 18:33:12 +0100")
References: <20170308173315.28512-1-gregory.clement@free-electrons.com>
Message-ID: <87wpbgc5a6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., mars 08 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> The first patch fixes a wrong IRQ number present since the
> introduction of the device tree for this SoC.
>
> The second and the third ones improve the USB3 representation
> following the add of the clock support on Armada 37xx and the gpio
> expander on Armada 3720 DB.
>
> Thanks,
>
> Gregory
>
> Gregory CLEMENT (3):
>   ARM64: dts: marvell: armada-37xx: Fix interrupt mapping for USB3
>   ARM64: dts: marvell: armada-37xx: Add clock resource for USB3
>   ARM64: dts: marvell: armada-3720-db: Add phy for USB3

All 3 patches applied on mvebu/dt64

Gregory

>
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  3 ++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
