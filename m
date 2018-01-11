From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 11 Jan 2018 10:14:22 +0100
Subject: [PATCH v2 0/3] ARM: mvebu: dts: updates to enable EDAC
In-Reply-To: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Thu, 11 Jan 2018 14:59:00 +1300")
References: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87a7xk7o5t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., janv. 11 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> I've split this off from my earlier series[1] this is just the dts changes that
> will enable support for the EDAC series when it lands.
>
> The Armada 38x as well as the 98dx3236 and similar switch chips with integrated
> CPUs use the same SDRAM controller block as the Armada XP. The key difference
> is the width of the DDR interface.
>
> [1] - https://marc.info/?l=linux-kernel&m=151545124505964&w=2

The series is looks good now. For patch 1 I still wait for that
the "marvell,,ecc-enable" property was accepted before merging it.

So I can either wait for that it was accepted before applying the series,
or just applying patch 2 and 3 for now, as you want.

Thanks,

Gregory


>
> Changes in v2:
> - update commit message
> - add labels to dts
>
> Chris Packham (3):
>   ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
>   ARM: dts: armada-xp: add label to sdram-controller node
>   ARM: dts: mvebu: add sdram controller node to Armada-38x
>
>  arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
>  arch/arm/boot/dts/armada-xp.dtsi              | 2 +-
>  4 files changed, 12 insertions(+), 2 deletions(-)
>
> -- 
> 2.15.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
