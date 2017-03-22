From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 19:20:56 +0300
Subject: [PATCH] ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc
 for rk3188
In-Reply-To: <11123239.Wc863F7R2R@phil>
References: <1490109227-4006-1-git-send-email-al.kochet@gmail.com>
 <11123239.Wc863F7R2R@phil>
Message-ID: <C2BC0A84-EF69-42E3-84FA-A873B8A7187A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Heiko!

> 22 ????? 2017 ?., ? 18:54, Heiko Stuebner <heiko@sntech.de> ???????(?):
> 
> I've applied a slightly different variant in [0] with your commit message and
> moved the dma properties to the mmc/emmc nodes in rk3xxx.dtsi - as the dma
> channels are the same on both rk3188 and rk3066.

Thank you! I had changes in the rk3xxx.dtsi initially, but them moved them
into rk3188. Don?t know why I did that. May be because I don?t have rk3066
based board to test on.

> While at it, I've also added the sdio dma as there is no need to leave it out.

I?ve tested mmc0 and emm and they work great. I haven?t tested sdio.

> 
> Also when changing the devicetree, please do not append stuff at the bottom
> but instead sort new nodes (the &mmc &emmc in this case) and properties
> alphabetically.

Ok. Thank you.

I have working settings for eMMC for radxa rock. What do you think, is it good idea to add them
to the kernel DT? As Radxa Rock doesn?t come with eMMC, but eMMC can be soldered manually.

Alexander.
