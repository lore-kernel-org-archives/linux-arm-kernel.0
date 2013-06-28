From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Jun 2013 18:15:32 +0100
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
In-Reply-To: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130628171532.GD30603@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 05:44:02PM +0100, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Sorry for steping in so late, but these two patches fixes a warning
> introduced by the commit 1ba9bf0a (ARM: 7762/1: kernel: fix
> arm_dt_init_cpu_maps() to skip non-cpu nodes) after 3.10-rc7.
> 
> These two patches solve the situation for sunxi. The first one by
> Lorenzo is to be applied for 3.10 if it's still possible, and the
> second one on top of arm-soc/for-next. Tell me if you prefer a more
> formal pull request for these patches
> 
> Thanks!
> Maxime
> 
> Lorenzo Pieralisi (1):
>   ARM: dts: sunxi: cpus/cpu nodes dts updates

The patch above should already be queued in next/dt right ?

Thanks,
Lorenzo

> 
> Maxime Ripard (1):
>   sunxi: a10s: dtsi: Convert cpu node to the new cpu bindings
> 
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 2 ++
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 2 ++
>  arch/arm/boot/dts/sun5i-a13.dtsi  | 2 ++
>  3 files changed, 6 insertions(+)
> 
> -- 
> 1.8.3.1
> 
> 
