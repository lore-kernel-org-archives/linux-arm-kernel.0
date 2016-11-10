From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:22:27 +0100
Subject: [PATCH 08/14] ARM: dts: armada-375: Fixup pcie DT warnings
In-Reply-To: <20161110001000.10619-9-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 10 Nov 2016 01:09:54 +0100")
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
 <20161110001000.10619-9-gregory.clement@free-electrons.com>
Message-ID: <87twbgkwu4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
 
 On jeu., nov. 10 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> PCIe has a ranges property, so the unit name should contain an address.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 700d80fe0d85..a157b62e810e 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -580,7 +580,7 @@
>  			};
>  		};
>  
> -		pciec: pcie-controller at 82000000@ {
> +		pciec: pcie-controller at 82000000 {

I don't know what happened but this patch should have been squashed in
the previous one.

I will fix it before applying on the mvebu tree of course.

Gregory


>  			compatible = "marvell,armada-370-pcie";
>  			status = "disabled";
>  			device_type = "pci";
> -- 
> 2.10.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
