From: rocky.hao@rock-chips.com (rocky.hao)
Date: Thu, 27 Jul 2017 14:49:37 +0800
Subject: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RK3328 SoC
 compatible
In-Reply-To: <4621265.xPXIvBV6Fl@diego>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
 <1500973788-14627-2-git-send-email-rocky.hao@rock-chips.com>
 <4621265.xPXIvBV6Fl@diego>
Message-ID: <4c4a3974-e841-3d98-9850-131711c40c61@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,
Thank you for the quick reply. I will remove the gerrit Change-Ids in my 
v2 patches.

Thanks again,
Rocky

? 2017/7/27 14:36, Heiko St?bner ??:
> Hi Rocky,
> 
> Am Dienstag, 25. Juli 2017, 17:09:44 CEST schrieb Rocky Hao:
>> attempt to new compatible for thermal founding on RK3328 SoC.
>>
>> Change-Id: Ie6f6d7b4e545891a0035851a923c0412f584140c
>> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> 
> generally looks good but you should not have gerrit Change-Ids in patches
> for mainline. This is true for all patches in this series.
> 
> 
> Heiko
> 
>> ---
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt index
>> 43003aec94bd..e3a6234fb1ac 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>>      "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>> +   "rockchip,rk3328-tsadc": found on RK3328 SoCs
>>      "rockchip,rk3368-tsadc": found on RK3368 SoCs
>>      "rockchip,rk3399-tsadc": found on RK3399 SoCs
>>   - reg : physical base address of the controller and length of memory mapped
> 
> 
> 
> 
> 
