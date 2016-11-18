From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:32:31 -0800
Subject: [GIT PULL 2/3] Rockchip dts32 changes for 4.10
In-Reply-To: <2517910.T56YgEDzxC@phil>
References: <1698724.ZQnZMjf8xY@phil>
 <2517910.T56YgEDzxC@phil>
Message-ID: <20161118073231.GJ1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 04:35:49PM +0100, Heiko Stuebner wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-dts32-1
> 
> for you to fetch changes up to 6a8883d614c7bede1075a4850139daa9723c291e:
> 
>   ARM: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max" (2016-11-09 14:46:04 +0100)
> 
> ----------------------------------------------------------------
> 32bit devicetree changes for Rockchip including removal of skeleton.dtsi
> inclusion, missing unit names for memory nodes, various frequency
> optimizations allowing for better performance on rk3066, the usage of
> pin constants to bridge between the two numbering schemes used (gpio
> controllers using 0-31 and pins being labeled A0-A7,..., D0-D7)
> and UHS/HS modes for the mmc controllers on the popmetal board.
> 
> Two new boards, the PX3-based evaluation board, with the PX3 being an
> industrial variant of the rk3188 soc and the Rikomagic MK808 board
> based around the rk3066 are also added.

Merged, thanks!


-Olof
