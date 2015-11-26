From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 26 Nov 2015 10:57:49 +0800
Subject: [PATCH 3/5] dt-bindings: rockchip-thermal: Support the
 RK3228/RK3399 SoCs compatible
In-Reply-To: <11146001.lIrLtFf7Xg@diego>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
 <1448438377-29203-4-git-send-email-wxt@rock-chips.com>
 <11146001.lIrLtFf7Xg@diego>
Message-ID: <5656752D.2010707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?11?25? 22:56, Heiko St?bner ??:
> Am Mittwoch, 25. November 2015, 15:59:35 schrieb Caesar Wang:
>> This patchset attempts to new compatible for thermal founding
>> on RK3228/RK3399 SoCs.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt index
>> 0dfa60d..af5f802 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -2,8 +2,10 @@
>>
>>   Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>> +   "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>>      "rockchip,rk3368-tsadc": found on RK3368 SoCs
>> +   "rockchip,rk3368-tsadc": found on RK3399 SoCs
> copy'n'paste error, should proably be
>   "rockchip,rk3399-tsadc": found on RK3399 SoCs

Fixed in next version, thanks!
>>   - reg : physical base address of the controller and length of memory mapped
>> region.
>>   - interrupts : The interrupt number to the cpu. The interrupt specifier
>> format
>
>
>

-- 
caesar wang | software engineer | wxt at rock-chip.com
