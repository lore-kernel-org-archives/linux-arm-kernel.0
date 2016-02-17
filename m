From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 17 Feb 2016 15:23:14 +0800
Subject: [PATCH 4/6] pinctrl: rockchip: add bindings for rk3399 pinctrl
In-Reply-To: <19942952.P4nUQKPo3g@phil>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455673992-16469-5-git-send-email-jay.xu@rock-chips.com>
 <19942952.P4nUQKPo3g@phil>
Message-ID: <56C41FE2.8020800@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 17/02/2016 14:47, Heiko Stuebner ??:
> Hi Jianqun,
>
> Am Mittwoch, 17. Februar 2016, 09:53:10 schrieb jianqun.xu:
>> From: Xu Jianqun <jay.xu@rock-chips.com>
>>
>> Add devicetree bindings for pinctrl found on rk3399
>> processors from rockchip.
>>
>> Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt index
>> 0cd701b..c68b955 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
>> @@ -22,7 +22,7 @@ Required properties for iomux controller:
>>     - compatible: one of "rockchip,rk2928-pinctrl",
>> "rockchip,rk3066a-pinctrl" "rockchip,rk3066b-pinctrl",
>> "rockchip,rk3188-pinctrl"
>>   		       "rockchip,rk3228-pinctrl", "rockchip,rk3288-pinctrl"
>> -		       "rockchip,rk3368-pinctrl"
>> +		       "rockchip,rk3368-pinctrl", "rockchip,rk3399-pinctrl"
>>     - rockchip,grf: phandle referencing a syscon providing the
>>   	 "general register files"
>
> that is already contained in David's core pinctrl patch that already got
> applied to the pinctrl tree.
>
Sorry very much, I forgot it after a long time of spring holiday
thanks
>
> Heiko
>
>
>
