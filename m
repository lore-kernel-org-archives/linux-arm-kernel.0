From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Sep 2017 14:04:49 +0200
Subject: [PATCH v2 0/4] arm64: marvell: 7k/8k: improve network support
In-Reply-To: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 21 Sep 2017 09:54:06 +0200")
References: <20170921075410.19072-1-antoine.tenart@free-electrons.com>
Message-ID: <87k20rkkgu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., sept. 21 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi all,
>
> This series improves the network support on Marvell 7k and 8k platforms
> by adding descriptions of the comphy, and by using the comphy in already
> available networking ports. The series also introduces a description of
> the SFP ports on the Marvell Armada 7040-db and 8040-db.
>
> Two defconfig patches also improve the Marvell ARM64 support by enabling
> required options allowing to use the networking ports properly.
>
> This series follows recent improvements in the PPv2 driver.
>
> Based on v4.14-rc1, and tested on the Marvell Armada 7040-db, 8040-db
> and 8040-mcbin.
>
> Thanks!
> Antoine
>
> Since v1:
>   - Added comments in nodes using both a network PHY and a generic PHY.
>   - 4 patches were applied on mvebu trees.
>
> Antoine Tenart (4):
>   arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
>   arm64: dts: marvell: 7040-db: add comphy reference to Ethernet port
>   arm64: dts: marvell: 7040-db: enable the SFP port
>   arm64: dts: marvell: 8040-db: enable the SFP ports
>

All applied on mvebu/dt64 and first with Testdd-by from Andrew.

Thanks,

Gregory


>  arch/arm64/boot/dts/marvell/armada-7040-db.dts    | 11 +++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 10 ++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |  9 +++++++++
>  3 files changed, 30 insertions(+)
>
> -- 
> 2.13.5
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
