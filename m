From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 15:01:45 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: add an stdout-path
In-Reply-To: <20170717073022.25452-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 17 Jul 2017 09:30:22 +0200")
References: <20170717073022.25452-1-antoine.tenart@free-electrons.com>
Message-ID: <877ez599vq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., juil. 17 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> This patch adds an stdout-path to the mcbin device tree. This allows to
> use earlycon.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index a4f87faae67b..178fe1fca015 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -51,6 +51,10 @@
>  	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
>  			"marvell,armada-ap806-quad", "marvell,armada-ap806";
>  
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>  	memory at 00000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
> -- 
> 2.13.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
