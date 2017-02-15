From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Feb 2017 15:35:14 +0100
Subject: [PATCH v2 1/6] ARM: dts: Fix typo in armada-xp-98dx4251
In-Reply-To: <20170207202815.20226-2-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Wed, 8 Feb 2017 09:28:10 +1300")
References: <20170207202815.20226-1-chris.packham@alliedtelesis.co.nz>
 <20170207202815.20226-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <87zihncyjh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On mar., f?vr. 07 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The compatible should be 98dx4251 not 98dx4521.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt

If it's too late for a PR to arm-soc I will move it in mvebu/fixes once
the v4.11-rc1 will be released.

Thanks,

Gregory

> ---
>
> Notes:
>     Changes in v2
>     - new
>
>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
> index 4b0533a4ccb7..b9d9b269efb4 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
> @@ -49,7 +49,7 @@
>  
>  / {
>  	model = "Marvell 98DX4251 SoC";
> -	compatible = "marvell,armadaxp-98dx4521", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
> +	compatible = "marvell,armadaxp-98dx4251", "marvell,armadaxp-98dx3236", "marvell,armadaxp", "marvell,armada-370-xp";
>  
>  	cpus {
>  		cpu at 1 {
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
