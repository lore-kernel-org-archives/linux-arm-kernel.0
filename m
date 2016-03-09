From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed, 09 Mar 2016 16:48:31 +0800
Subject: [PATCH v5 5/6] dt/bindings: rockchip: modify document of Rockchip
 power domains
In-Reply-To: <56DEB2E1.6060808@gmail.com>
References: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
 <1456992557-25331-1-git-send-email-zhangqing@rock-chips.com>
 <56DEB2E1.6060808@gmail.com>
Message-ID: <56DFE35F.3010400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/08/2016 07:09 PM, Caesar Wang wrote:
>
>
> ? 2016?03?03? 16:09, Elaine Zhang ??:
>> Add binding documentation for the power domains
>> found on Rockchip RK3399 SoCs.
>> RK3399 pd on/off not need to enable clk which in this pd.
>> So remove the clocks in the rk3399 pd example.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../bindings/soc/rockchip/power_domain.txt         | 37
>> ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> index 13dc6a3..98085c8 100644
>> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> @@ -7,6 +7,7 @@ Required properties for power domain controller:
>>   - compatible: Should be one of the following.
> [....]
>>   Example of the node using power domain:
>> @@ -65,3 +96,9 @@ Example of the node using power domain:
>>                   power-domains = <&power RK3368_PD_GPU_1>;
>>                   /* ... */
>>           };
>> +
>> +    node {
>> +        /* ... */
>> +        power-domains = <&power RK3399_PD_VOPB>;
>> +        /* ... */
>> +    };
>
> Trivial: typo
>                  power: power-controller {
> @@ -92,10 +92,10 @@ Example of the node using power domain:
>          };
>
>          node {
> -                /* ... */
> -                power-domains = <&power RK3368_PD_GPU_1>;
> -                /* ... */
> -        };
> +               /* ... */
> +               power-domains = <&power RK3368_PD_GPU_1>;
> +               /* ... */
> +       };
This is a example.I think there is no problem.

>
>
>
>
>
