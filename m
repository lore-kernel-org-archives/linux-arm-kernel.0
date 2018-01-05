From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 17:12:52 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.16 (#2)
In-Reply-To: <878tdcbu69.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 05 Jan 2018 09:12:46 +0100")
References: <878tdcbu69.fsf@free-electrons.com>
Message-ID: <87fu7k9tdn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., janv. 05 2018, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> Here is the second pull request for dt64 for mvebu for v4.16.

Please do not pull this version but the second version I have just sent.

Thanks,

Gregory

>
> Gregory
>
> The following changes since commit 4cada03801992d09ccceaf5f462e9dadb75a9613:
>
>   ARM64: dts: marvell: Add thermal support for A7K/A8K (2017-12-18 17:13:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.16-2
>
> for you to fetch changes up to 38027b7d7c27c185a3e4e70f8d83509c3eda0daf:
>
>   arm64: dts: marvell: add Ethernet aliases (2018-01-03 17:07:50 +0100)
>
> ----------------------------------------------------------------
> mvebu dt64 for 4.16 (part 2)
>
> The main change here are the series of commits doing the Armada 7K/8K
> CP110 DT de-duplication, they include the de-duplication itself and
> small fixes in the device tree files.
>
> Besides them there are 2 other patches:
>  - One adding the crypto support for Armada 37xx SoCs
>  - An other adding Ethernet aliases on A7K/A8K base boards
>
> ----------------------------------------------------------------
> Antoine Tenart (1):
>       arm64: dts: marvell: armada-37xx: add a crypto node
>
> Thomas Petazzoni (8):
>       arm64: dts: marvell: fix watchdog unit address in Armada AP806
>       arm64: dts: marvell: use lower case for unit address and reg property
>       arm64: dts: marvell: fix typos in comment describing the NAND controller
>       arm64: dts: marvell: fix compatible string list for Armada CP110 slave NAND
>       arm64: dts: marvell: use mvebu-icu.h where possible
>       arm64: dts: marvell: use aliases for SPI busses on Armada 7K/8K
>       arm64: dts: marvell: de-duplicate CP110 description
>       arm64: dts: marvell: replace cpm by cp0, cps by cp1
>
> Yan Markman (1):
>       arm64: dts: marvell: add Ethernet aliases
>
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  14 +
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  52 +--
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  37 +-
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   2 +-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  87 ++--
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  82 ++--
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   2 +-
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  80 +++-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   8 +-
>  arch/arm64/boot/dts/marvell/armada-common.dtsi     |  10 +
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 449 ---------------------
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 448 --------------------
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 422 +++++++++++++++++++
>  13 files changed, 668 insertions(+), 1025 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
>  delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>  delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi
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
