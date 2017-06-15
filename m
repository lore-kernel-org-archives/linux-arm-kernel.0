From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jun 2017 18:11:42 +0200
Subject: [PATCH v3 0/6] Update device tree for Armada 3720 DB
In-Reply-To: <20170613135711.7622-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 13 Jun 2017 15:57:05 +0200")
References: <20170613135711.7622-1-gregory.clement@free-electrons.com>
Message-ID: <87mv996xj5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., juin 13 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> the main purpose of this short series is to add the support of the
> second SDHCI controller on the Armada 3720 DB board (and on the Armada
> 37xx SoC).
>
> This series also adds some improvement to the device tree of the the
> Armada 3720 DB board and the last patch allow using higher speed on
> the SD card by adding the vqmmc regulator.
>
> In the v3, I use the angle bracket for each set of register. And I
> added the reviewed by flag from Andreas F?rber.
>
> In the v2, I added a patch aligning the compatible string and fix the
> patch " arm64: dts: marvell: Enable second SDHCI controller in Armada
> 37xx" too.
>
> Gregory
>
>
> Gregory CLEMENT (5):
>   arm64: dts: marvell: armada-3720-db: Sort the dts node alphabetically
>   arm64: dts: marvell: armada-3720-db: Add information about the V2
>     board
>   arm64: dts: marvell: armada-37xx: Align the compatible string
>   arm64: dts: marvell: armada-37xx: Use angle bracket for each register
>     set
>   arm64: dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot
>
> Konstantin Porotchkin (1):
>   arm64: dts: marvell: Enable second SDHCI controller in Armada 37xx

All series applided on mvebu/dt

Gregory

>
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 120 ++++++++++++++++---------
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  25 ++++--
>  2 files changed, 94 insertions(+), 51 deletions(-)
>
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
