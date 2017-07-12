From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 12 Jul 2017 08:21:00 +0800
Subject: [PATCH 5/5] dt-bindings: display: fill Documents for series of vop
In-Reply-To: <7391489.lxuf2bMt0N@diego>
References: <1499776908-16811-1-git-send-email-mark.yao@rock-chips.com>
 <1499776958-17062-1-git-send-email-mark.yao@rock-chips.com>
 <7391489.lxuf2bMt0N@diego>
Message-ID: <59656B6C.5020308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?07?11? 20:45, Heiko St?bner wrote:
> Hi Mark,
>
> Am Dienstag, 11. Juli 2017, 20:42:38 CEST schrieb Mark Yao:
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 4
>> ++++ 1 file changed, 4 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>> b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt index
>> 9eb3f0a..11fa3b0 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
>> @@ -8,8 +8,12 @@ Required properties:
>>   - compatible: value should be one of the following
>>   		"rockchip,rk3036-vop";
>>   		"rockchip,rk3288-vop";
>> +		"rockchip,rk3368-vop";
>> +		"rockchip,rk3366-vop";
>>   		"rockchip,rk3399-vop-big";
>>   		"rockchip,rk3399-vop-lit";
>> +		"rockchip,rk322x-vop";
> please don't use wildcards in devicetree compatibles. We've somehow
> standardized on using rk3228 for both the rk3228 and rk3229 (which are
> nearly the same soc with some speed adjustments)
>
> So,
> +		"rockchip,rk3228-vop";
> please
>
>
> Thanks
> Heiko

Got it, I will fix it at next version

Thanks
Mark

>
>> +		"rockchip,rk3328-vop";
>>
>>   - interrupts: should contain a list of all VOP IP block interrupts in the
>>   		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
>
>
>
>
