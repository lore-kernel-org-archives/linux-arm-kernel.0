From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Aug 2015 09:37:29 +0900
Subject: [PATCH 0/4] ARM: dts: exynos3250: Add UART2 and MMC2 dt node with
 related clocks
In-Reply-To: <55D12C73.6090101@samsung.com>
References: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
 <CAJKOXPfvGypFymHzXDMEA295Copi0sjpMG9oKmJ+a_BQoK+SNw@mail.gmail.com>
 <55D12C73.6090101@samsung.com>
Message-ID: <55D12CC9.2060602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.08.2015 09:36, Chanwoo Choi wrote:
> On 08/17/2015 09:33 AM, Krzysztof Kozlowski wrote:
>> 2015-08-11 12:46 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
>>> This patch add the UART2 / MMC2 devicetree node for Exynos3250 SoC and add
>>> the related clocks (mux, divider, gate) of UART2 / MMC2 device.
>>
>> What is the benefit of adding them? Why they are needed?
> 
> UART2 /MMC2 are used on Exynos3250-based ARTIK-5 board[1].
> [1] https://www.artik.io/hardware/artik-5

Thanks for explaining this. The patchset missed that information - the
purpose. I'll start reviewing it.

Best regards,
Krzysztof

> 
> Thanks,
> Chanwoo Choi
> 
>>
>> Best regards,
>> Krzysztof
>>
>>
>>>
>>> Chanwoo Choi (4):
>>>   clk: samsung: exynos3250: Add UART2 clock
>>>   clk: samsung: exynos3250: Add MMC2 clock
>>>   ARM: dts: Add UART2 dt node for Exynos3250 SoC
>>>   ARM: dts: Add MSHC2 dt node for Exynos3250 SoC
>>>
>>>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 42 +++++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos3250.dtsi         | 25 ++++++++++++++++++
>>>  drivers/clk/samsung/clk-exynos3250.c      | 15 +++++++++++
>>>  include/dt-bindings/clock/exynos3250.h    | 11 +++++++-
>>>  4 files changed, 92 insertions(+), 1 deletion(-)
>>>
>>> --
>>> 1.8.5.5
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
