From: rocky.hao@rock-chips.com (rocky.hao)
Date: Fri, 15 Sep 2017 11:20:33 +0800
Subject: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RV1108 SoC
 compatible
In-Reply-To: <12073627-41af-3480-6379-839e07f5e8f3@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-2-git-send-email-rocky.hao@rock-chips.com>
 <12073627-41af-3480-6379-839e07f5e8f3@rock-chips.com>
Message-ID: <ce37b9e1-2095-f5ad-e414-2663b4b43755@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Thanks for the reply.

? 2017/9/15 9:49, Caesar Wang ??:
> Hi Rocky,
> 
> ? 2017?08?24? 18:27, Rocky Hao ??:
>> Add a new compatible for thermal founding on RV1108 SoCs.
>>
>> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt 
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> index e3a6234fb1ac..43d744e5305e 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -2,6 +2,7 @@
>>   Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>> +   "rockchip,rv1108-tsadc": found on RV1108 SoCs
> 
> According to the order,  we should put the string after the 
> "rockchip,rk3399-tsadc"..., not here.
It is okay for me.
>>      "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>>      "rockchip,rk3328-tsadc": found on RK3328 SoCs
> 
> 
> 
> 
