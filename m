From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Aug 2015 17:09:45 +0530
Subject: [PATCH 5/5] Documentation: dt-bindings: add exynos-srom binding
 information
In-Reply-To: <CAJKOXPfpu+k-3u3kFzeKL4b9bkh+iwWHak2ea+9QLtGUEZGWdA@mail.gmail.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
 <1430296712-10287-6-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPfpu+k-3u3kFzeKL4b9bkh+iwWHak2ea+9QLtGUEZGWdA@mail.gmail.com>
Message-ID: <55D5BC81.9050304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Wednesday 27 May 2015 04:51 PM, Krzysztof Kozlowski wrote:
> 2015-04-29 17:38 GMT+09:00 Pankaj Dubey <pankaj.dubey@samsung.com>:
>> This patch adds exynos-srom binding information for SROM Controller
>> driver on Exynos SoCs.
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   .../devicetree/bindings/arm/samsung/exynos-srom.txt          | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
>> new file mode 100644
>> index 0000000..482d1cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
>> @@ -0,0 +1,12 @@
>> +SAMSUNG Exynos SoCs SROM Controller driver.
>> +
>> +Required properties:
>> +- compatible : Should at least contain "samsung,exynos-srom".
>
> "At least" - do you already expect other compatibles?
>

Nope, as of now I do not expect any other compatible, so I will change 
this to "Should contain "samsung,exynos-srom"."

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
>
