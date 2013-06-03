From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 3 Jun 2013 16:34:33 +0200
Subject: [GIT PULL] ARM: OMAP: dts fixes for 3.10-rc4
In-Reply-To: <51A8A459.1000706@ti.com>
References: <51A8A459.1000706@ti.com>
Message-ID: <51ACA979.9060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 05/31/2013 03:23 PM, Benoit Cousson wrote:
> Hi Tony,
> 
> Please pull two DTS fixes for the next -rc.

Please ignore that one. I'll send a new one with one more fix ASAP.

Thanks,
Benoit

> 
> Thanks,
> Benoit
> 
> 
> The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
>   Linus Torvalds (1):
>         Linux 3.10-rc3
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git dts-fixes-for-3.10
> 
> Kevin Hilman (1):
>       ARM: dts: omap4-panda|sdp: Fix mux for twl6030 IRQ pin and msecure line
> 
> Lars Poeschel (1):
>       ARM: dts: AM33xx: Fix properties on gpmc node
> 
>  arch/arm/boot/dts/am33xx.dtsi             |    4 ++--
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++++++++++++
>  3 files changed, 42 insertions(+), 2 deletions(-)
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
