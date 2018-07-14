From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 15:11:05 -0700
Subject: [GIT PULL] Rockchip dts32 fix for 4.18
In-Reply-To: <1776596.Q4iCTXTKyP@phil>
References: <1776596.Q4iCTXTKyP@phil>
Message-ID: <20180714221105.u7gbyetcpjhlylfl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 04:18:55PM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below a one-patch pull fixing a new warning the updated dtc
> in 4.18 found. So far no other regressions have been found in Rockchip
> parts it seems. So please pull!
> 
> Thanks
> Heiko
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-dts32fixes-1
> 
> for you to fetch changes up to cddb86833615d9550d7b3a1b65b71071784dae70:
> 
>   ARM: dts: rockchip: fix graph node unit address error from dtc (2018-06-17 09:31:34 +0200)

I took the liberty to declare this non-urgent and queued it up with next/dt
instead for 4.19. It's just a warning and we're past rc4 so it seemed like
a reasonable call. Let me know if it has actual functional impact/regression
though.


-Olof
