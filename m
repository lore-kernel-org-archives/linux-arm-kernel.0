From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 13:10:48 +0200
Subject: [PATCH v2 1/7] clocksource: exynos_mct: Add the support for ARM64
In-Reply-To: <562e232f-7e69-6d54-e49d-36042d166800@linaro.org>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-2-git-send-email-cw00.choi@samsung.com>
 <562e232f-7e69-6d54-e49d-36042d166800@linaro.org>
 <CGME20160916111052eucas1p1fb19531ab7b3e53f6fdeb4fa0e8a5449@eucas1p1.samsung.com>
Message-ID: <18cb09bb-7a03-df7f-706d-5309b34e222b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2016 01:04 PM, Daniel Lezcano wrote:
> On 24/08/2016 15:49, Chanwoo Choi wrote:
>> This patch adds the support for ARM 64bit. The delay_timer is only supported
>> on ARM 32bit.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
> 
> I don't really like #ifdef in the code itself but I suppose there is no
> much choice.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, applied.
If needed, I can provide a stable tag to base on top of it.

Best regards,
Krzysztof
