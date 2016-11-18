From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:33:03 -0800
Subject: [GIT PULL 3/3] Rockchip dts64 changes for 4.10
In-Reply-To: <4932547.OPNQihgQS9@phil>
References: <1698724.ZQnZMjf8xY@phil>
 <4932547.OPNQihgQS9@phil>
Message-ID: <20161118073303.GK1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 04:36:25PM +0100, Heiko Stuebner wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-dts64-1
> 
> for you to fetch changes up to c49590691f3819bb6be3f77938ef39038eb76643:
> 
>   arm64: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max" (2016-11-09 15:08:55 +0100)
> 
> ----------------------------------------------------------------
> 64bit devicetree changes including the px5 evaluation board
> a fix for wrong i2c registers on rk3368 a new nvmem cell and
> power-domain on rk3399 as well as moving mmc frequency
> properties to the more generic max-frequency one.
> 
> ----------------------------------------------------------------
> Andy Yan (2):
>       arm64: dts: rockchip: fix i2c resource error of rk3368
>       arm64: dts: rockchip: Add PX5 Evaluation board
> 
> Chris Zhong (1):
>       arm64: dts: rockchip: add powerdomain for typec on rk3399
> 
> Jaehoon Chung (1):
>       arm64: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max"
> 
> Shawn Lin (2):
>       arm64: dts: rockchip: Add more properties for emmc on px5-evb
>       arm64: dts: rockchip: add sdmmc support for px5-evb
> 
> Ziyuan Xu (1):
>       arm64: dts: rockchip: add cpu-id nvmem cell node for rk3399

Merged, thanks!


-Olof
