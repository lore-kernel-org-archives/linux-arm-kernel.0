From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Oct 2017 18:13:57 -0700
Subject: [GIT PULL v2] Rockchip dts64 Fixes for 4.14
In-Reply-To: <2709130.jIo7eQHvkl@phil>
References: <6990785.aOlALvEuSf@phil>
 <2709130.jIo7eQHvkl@phil>
Message-ID: <20171004011357.bclazdklfeuzdqev@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 08:11:32PM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below three fixes for 64bit Rockchip devicetrees.
> 
> As the tag explains the main change is the revert of the rk3368 opp
> addition, as this cannot safely run on current rk3368 boards and thus
> shouldn't make a kernel release.
> 
> 
> Please pull, thanks
> Heiko
> 
> changes in v2:
> - remove left over half-sentence at the end of the tag message
> - add rk3399 mipi dsi grf-clock reference (part of the binding already
>   and of course needed on rk3399)
> 
> 
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64fixes-1
> 
> for you to fetch changes up to 0bc15d85d97d44e8979ff91d0c1fbafe6fd4172c:
> 
>   arm64: dts: rockchip: add the grf clk for dw-mipi-dsi on rk3399 (2017-09-26 15:59:17 +0200)

Merged to fixes, thanks.


-Olof
