From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Jan 2016 18:36:44 +0100
Subject: [PATCH 0/2] Add Mediatek MT2701 SMP support
In-Reply-To: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
References: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
Message-ID: <56A1172C.5070509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/01/16 13:09, Louis Yu wrote:
> This patchset is based on 4.4-rc8 and [1], and contains smp support
> for Mediatek MT2701. MT2701 contains 4 CA7 cores.
>
> This patchset adds related SMP support for Mediatek MT2701.
>
> [1] https://patchwork.kernel.org/patch/7248471/
>
> Louis Yu (2):
>    ARM: mediatek: add mt2701 smp bringup code
>    ARM: dts: mt2701: enable basic SMP bringup for mt2701
>
>   arch/arm/boot/dts/mt2701.dtsi    |   12 ++++++++++++
>   arch/arm/mach-mediatek/platsmp.c |    1 +
>   2 files changed, 13 insertions(+)
>

Applied to v4.5-next/(soc,dts)

Thanks.
Matthias
