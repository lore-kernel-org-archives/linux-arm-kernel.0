From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Jun 2013 15:07:07 -0700
Subject: [GIT PULL v2] ARM: dts: OMAP fixes for 3.10-rc5
In-Reply-To: <51ACA9FA.9000308@ti.com>
References: <51ACA9FA.9000308@ti.com>
Message-ID: <20130607220706.GO3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [130603 07:42]:
> Hi Tony,
> 
> Please pull three DTS fixes for the next -rc.

Thanks pulling into omap-for-v3.10/fixes.

Regards,

Tony
 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
>   Linus Torvalds (1):
>         Linux 3.10-rc4
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
> Suman Anna (1):
>       ARM: dts: OMAP5: Fix missing PWM capability to timer nodes
> 
>  arch/arm/boot/dts/am33xx.dtsi             |    4 ++--
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts           |   20 ++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi              |    3 +++
>  4 files changed, 45 insertions(+), 2 deletions(-)
