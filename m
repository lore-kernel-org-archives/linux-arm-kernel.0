From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2012 00:57:18 -0700
Subject: [GIT PULL] ARM: OMAP2+: Add AM335x and AM3517/05 EVM DT support
In-Reply-To: <4FAD0A71.80201@ti.com>
References: <4FAD0A71.80201@ti.com>
Message-ID: <20120605075718.GI12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120511 05:51]:
> Hi Tony,
> 
> Here are some remaining DT patches I was not able to push at 3.4 due to some missing dependency.
> It applies now fine on top of lo/dt branch.

Thanks pulling now into dt branch.

Tony
 
> Regards,
> Benoit
> 
> 
> The following changes since commit 40364b9f5a4d167d97bb6a76cd239ca8cfff056a:
>   Benoit Cousson (1):
>         arm/dts: omap4-panda: Add LEDs support
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.5/dts/am33xx
> 
> Vaibhav Hiremath (3):
>       arm/dts: Add support for TI AM335x EVM board
>       arm/dts: omap3-evm: Add i2c and twl4030 support
>       arm/dts: Add support for TI AM3517/05 EVM board
> 
>  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am3517-evm.dts |   32 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-evm.dts  |   28 +++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am335x-evm.dts
>  create mode 100644 arch/arm/boot/dts/am3517-evm.dts
