From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 19 Apr 2016 16:13:00 -0400
Subject: [PATCH] ARM: dts: exynos: Remove unsupported s2mps11 regulator
 bindings from Exynos5420 boards
In-Reply-To: <5715C629.1030602@samsung.com>
References: <1460965453-5337-1-git-send-email-k.kozlowski@samsung.com>
 <571510D5.3090406@osg.samsung.com> <5715C629.1030602@samsung.com>
Message-ID: <5716914C.1030102@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/19/2016 01:46 AM, Krzysztof Kozlowski wrote:
> On 04/18/2016 06:52 PM, Javier Martinez Canillas wrote:

[snip]

>>
>> On a related note, the s5m8767 regulator driver parses similar DT properties
>> ("s5m8767,pmic-buck-ramp-delay", "s5m8767,pmic-buck2-ramp-enable", etc) that
>> are not in Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt.
>>
>> So those should either be added to the binding doc or removed from the driver
>> if are not correct (I don't have documentation for the s5m8767 PMIC but the
>> DT properties are not use by any DTS in mainline using the s5m8767 PMIC).
> 
> That's the grey area. :) I mean that instead of making these implemented
> bindings an interface, they should rather be converted to standard
> regulator bindings. However the device is quite old, not used on newer
> boards, so there is no interest in improving this. In the same time
> removal of this code is not strictly necessary. Its existence does not hurt.
>

Fair enough.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
