From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 12 Jan 2015 18:14:29 +0900
Subject: [PATCH] ARM: samsung: add exynos-chipid binding information
In-Reply-To: <54AA5D1D.9000409@samsung.com>
References: <1417592664-10672-1-git-send-email-pankaj.dubey@samsung.com>
 <54AA5D1D.9000409@samsung.com>
Message-ID: <54B39075.20406@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/15 18:45, Pankaj Dubey wrote:
> Gentle Ping.
> 
> On Wednesday 03 December 2014 01:14 PM, Pankaj Dubey wrote:
>> Exynos SoC's DT files are using Chipid device nodes, but it's binding
>> information is missing. This patch adds exynos-chipid binding
>> information.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   .../bindings/arm/samsung/exynos-chipid.txt         |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
>> b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
>> new file mode 100644
>> index 0000000..85c5dfd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
>> @@ -0,0 +1,12 @@
>> +SAMSUNG Exynos SoCs Chipid driver.
>> +
>> +Required properties:
>> +- compatible : Should at least contain "samsung,exynos4210-chipid".
>> +
>> +- reg: offset and length of the register set
>> +
>> +Example:
>> +    chipid at 10000000 {
>> +        compatible = "samsung,exynos4210-chipid";
>> +        reg = <0x10000000 0x100>;
>> +    };
>>

I've applied. Sorry for late taking.

Thanks,
Kukjin
