From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 12:58:08 +0100
Subject: [PATCH 0/7] use SPDX-License-Identifier for Armada SoCs and boards
In-Reply-To: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 5 Jan 2018 12:53:22 +0100")
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
Message-ID: <87zi5sa567.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., janv. 05 2018, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> this series follow the recent trend for the license description to use
> the SPDX-License-Identifier.
>
> It also fix the wrongly stated X11 to MIT (see details in the commit
> logs).

I forgot to add that this series was only about the ARMv8 based Armada
SoCs. The ARMv7 and ARMv5 SoCs will be part of an other series.

Gregory

>
>
> Gregory CLEMENT (7):
>   arm64: dts: marvell: use SPDX-License-Identifier for Armada SoCs
>   arm64: dts: marvell: armada-3720-db: use SPDX-License-Identifier
>   arm64: dts: marvell: armada-3720-espressobin: use
>     SPDX-License-Identifier
>   arm64: dts: marvell: armada-7040-db: use SPDX-License-Identifier
>   arm64: dts: marvell: armada-8040-db: use SPDX-License-Identifier
>   arm64: dts: marvell: armada-8040-mcbin: use SPDX-License-Identifier
>   arm64: dts: marvell: armada-8080-db: use SPDX-License-Identifier
>
>  arch/arm64/boot/dts/marvell/armada-371x.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 39 +-------------------
>  .../boot/dts/marvell/armada-3720-espressobin.dts   | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 38 +-------------------
>  arch/arm64/boot/dts/marvell/armada-7020.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-7040.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8080-db.dts     | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-8080.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi       | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 41 +---------------------
>  .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 41 +---------------------
>  arch/arm64/boot/dts/marvell/armada-common.dtsi     |  2 +-
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  6 ++--
>  23 files changed, 24 insertions(+), 831 deletions(-)
>
> -- 
> 2.15.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
