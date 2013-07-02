From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 2 Jul 2013 14:12:25 +0200
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
In-Reply-To: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51D2C3A9.5080809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/2013 18:44, Maxime Ripard :
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

Just for the heads-up, the same happened to AT91 SAMA5D3.
As the solution is already in linux-next, we simply have to make sure 
that the patch is reported to the stable branches...

Bye,


>
> Thanks!
> Maxime
>
> Lorenzo Pieralisi (1):
>    ARM: dts: sunxi: cpus/cpu nodes dts updates
>
> Maxime Ripard (1):
>    sunxi: a10s: dtsi: Convert cpu node to the new cpu bindings
>
>   arch/arm/boot/dts/sun4i-a10.dtsi  | 2 ++
>   arch/arm/boot/dts/sun5i-a10s.dtsi | 2 ++
>   arch/arm/boot/dts/sun5i-a13.dtsi  | 2 ++
>   3 files changed, 6 insertions(+)
>


-- 
Nicolas Ferre
