From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 02 Oct 2018 16:44:58 +0200
Subject: [PATCH 0/2] Add CPU Idle support on Armada 8K
In-Reply-To: <20180921160916.12393-1-gregory.clement@bootlin.com> (Gregory
 CLEMENT's message of "Fri, 21 Sep 2018 18:09:14 +0200")
References: <20180921160916.12393-1-gregory.clement@bootlin.com>
Message-ID: <87sh1ommqd.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., sept. 21 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello,
>
> These two patches allow to enable the Idle support for Armada 8K
> boards.

Both patch applied on mvebu/dt64

Gregory

>
> Gregory
>
> Gregory CLEMENT (1):
>   arm64: dts: marvell: Add node labels for the cpus
>
> orenbh (1):
>   arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K
>
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi  |  2 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  2 +-
>  .../boot/dts/marvell/armada-ap806-dual.dtsi   |  4 +--
>  .../boot/dts/marvell/armada-ap806-quad.dtsi   | 12 ++++++---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 +++++++++++++++++++
>  .../marvell/armada-ap810-ap0-octa-core.dtsi   | 16 +++++------
>  6 files changed, 47 insertions(+), 16 deletions(-)
>
> -- 
> 2.19.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
