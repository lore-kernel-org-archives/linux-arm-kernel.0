From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:22:58 -0700
Subject: [GIT PULL 1/2] Rockchip dts32 changes for 4.8
In-Reply-To: <1666093.aVfPg2VmbT@phil>
References: <1666093.aVfPg2VmbT@phil>
Message-ID: <20160707052258.GJ32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:19:25AM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below arm devicetree changes for 4.8. The biggest part is
> probably the support for audio on veyron devices where the renaming was
> coordinated with the alsa side and the overturned name was never part of
> an actual release.
> 
> Apart from that Veyron also got a node for its spi flash and we now also
> support the ethernet and i2s controller on the rk3228/rk3229 siblings.
> 
> So if it looks ok, please pull
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.8-rockchip-dts32-1
> 
> for you to fetch changes up to 241eff3c198492b2d63e75723b774f2836fee8a3:
> 
>   ARM: dts: rockchip: add support rk3229 evb board (2016-06-27 21:38:50 +0200)

Merged, thanks!


-Olof
