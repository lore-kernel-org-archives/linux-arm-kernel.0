From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Sep 2015 11:59:01 +0200
Subject: [PATCH v4 2/5] ARM: mvebu: enable broken-idle on Armada 38x
In-Reply-To: <1443604246-29844-3-git-send-email-simon.guinot@sequanux.org>
 (Simon Guinot's message of "Wed, 30 Sep 2015 11:10:43 +0200")
References: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
 <1443604246-29844-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <874micqlcq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon and Vincent,

 On mer., sept. 30 2015, Simon Guinot <simon.guinot@sequanux.org> wrote:

> From: Vincent Donnefort <vdonnefort@gmail.com>
>
> Following the broken-idle DT property introduction, this patch enables
> this option for the Armada 38x SoCs. This allows to deactivate the idle
> state which is currently broken on this SoCs.

As explained in the previous email I would like that Armada 38x don't
use this flag.

Thanks,

Gregory

>
> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index f9f2347d9995..6d29afe12892 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -422,6 +422,7 @@
>  			coherency-fabric at 21010 {
>  				compatible = "marvell,armada-380-coherency-fabric";
>  				reg = <0x21010 0x1c>;
> +				broken-idle;
>  			};
>  
>  			pmsu at 22000 {

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
