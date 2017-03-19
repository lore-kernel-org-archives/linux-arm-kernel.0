From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 19 Mar 2017 10:34:22 +0000
Subject: [PATCH v1 2/7] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
In-Reply-To: <8664375.8vdE6CQfX9@phil>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489572237-6649-3-git-send-email-cl@rock-chips.com>
 <8664375.8vdE6CQfX9@phil>
Message-ID: <fff0d197-c88e-fd04-0f56-c4fbc982bae4@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/17 08:28, Heiko Stuebner wrote:
> Am Mittwoch, 15. M?rz 2017, 18:03:52 CET schrieb cl at rock-chips.com:
>> From: Chen Liang <cl@rock-chips.com>
>>
>> The rk3328 saradc is the same as rk3399.
>>
>> Signed-off-by: Chen Liang <cl@rock-chips.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt index
>> 205593f..f81bc20 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>     - "rockchip,saradc": for rk3188, rk3288
>>     - "rockchip,rk3066-tsadc": for rk3036
>>     - "rockchip,rk3399-saradc": for rk3399
>> +   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
> 
> not sure how iio people see that, but I would suggest keeping the order, so 
> put rk3328 above rk3399.
In my case I'm not that fussed either way. Still if this list keeps growing
I can see it would be better to keep it in numeric order!

Jonathan
> 
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
