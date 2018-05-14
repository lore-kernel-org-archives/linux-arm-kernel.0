From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 May 2018 07:20:29 +0900
Subject: [RFC PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
In-Reply-To: <20180514211610.26618-3-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <CGME20180514211906epcas4p2a4f34ce55a219a102e11de32be23e511@epcas4p2.samsung.com>
 <20180514211610.26618-3-enric.balletbo@collabora.com>
Message-ID: <5AFA0BAD.1050005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2018? 05? 15? 06:16, Enric Balletbo i Serra wrote:
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index 0ec68141f85a..951789c0cdd6 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,6 +12,8 @@ Required properties:
>  			 for details.
>  - center-supply:	 DMC supply node.
>  - status:		 Marks the node enabled/disabled.
> +- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
> +			 files".
>  
>  Optional properties:
>  - interrupts:		 The CPU interrupt number. The interrupt specifier
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
