From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 17:35:08 +0100
Subject: [PATCH] ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc
 for rk3188
In-Reply-To: <C2BC0A84-EF69-42E3-84FA-A873B8A7187A@gmail.com>
References: <1490109227-4006-1-git-send-email-al.kochet@gmail.com>
 <11123239.Wc863F7R2R@phil> <C2BC0A84-EF69-42E3-84FA-A873B8A7187A@gmail.com>
Message-ID: <1719178.VTn5J36Jb3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 22. M?rz 2017, 19:20:56 CET schrieb Alexander Kochetkov:
> Hello, Heiko!
> 
> > 22 ????? 2017 ?., ? 18:54, Heiko Stuebner <heiko@sntech.de> ???????(?):
> I have working settings for eMMC for radxa rock. What do you think, is it
> good idea to add them to the kernel DT? As Radxa Rock doesn?t come with
> eMMC, but eMMC can be soldered manually.

No, the Rock comes with a nand flash, which we hopefully will support at some 
point in the future. And in the mainline kernel we want to support the stock 
boards as people can buy them, not something people have soldered around on.


Heiko
