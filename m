From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Feb 2018 13:24:53 +0100
Subject: [PATCH 0/7] use SPDX-License-Identifier for Armada SoCs and boards
In-Reply-To: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 5 Jan 2018 12:53:22 +0100")
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
Message-ID: <87a7wboj1m.fsf@bootlin.com>
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
>
> Gregory
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

I haven't had anymore feedback since the first exchange a month ago so I
applied the series on mvebu/dt64 (The only change I have done was to
update my email address to bootlin.com)

Thanks,

Gregory



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

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
