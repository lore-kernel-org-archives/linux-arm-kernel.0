From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:23:42 -0700
Subject: [GIT PULL 2/2] Rockchip dts64 changes for 4.8
In-Reply-To: <5006101.OhzRdW27q2@phil>
References: <1666093.aVfPg2VmbT@phil>
 <5006101.OhzRdW27q2@phil>
Message-ID: <20160707052342.GK32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:22:19AM +0200, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below arm64 devicetree changes for 4.8.
> 
> Some new things for the rk3399 like emmc support as well some
> improvements+fixes for the rk3368 as explained in the tag.
> 
> So if ok, please pull
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.8-rockchip-dts64-1
> 
> for you to fetch changes up to 5d26ad9cfb2ebe2aba75342813e7542d5a68d644:
> 
>   arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins for rk3399 (2016-06-27 01:07:40 +0200)
> 
> ----------------------------------------------------------------
> The rk3399 gets support for its emmc controller as well as thermal,
> i2c and core io-domain nodes and some reasonable default rates
> for core clocks. The rk3368 also gets io-domains for its r88 board
> as well as a small fix for the gic's memory regions.

Merged, thanks.


-Olof
