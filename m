From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Jun 2015 08:53:11 +0900
Subject: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
In-Reply-To: <5110473.q5rJrrjs9a@vostro.rjw.lan>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
 <5110473.q5rJrrjs9a@vostro.rjw.lan>
Message-ID: <557F6567.1070901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.06.2015 08:47, Rafael J. Wysocki wrote:
> On Wednesday, June 03, 2015 05:18:18 PM Paul Gortmaker wrote:
>> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
>> and also contains modular function calls so it should explicitly include
>> module.h to avoid compile breakage during pending header shuffles.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: linux-pm at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-samsung-soc at vger.kernel.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I'm assuming that this will go in via the Samsung tree.
> 
> 
>> ---
>>
>> [ patch will be appended to the implicit include fixup series, see:
>>   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker at windriver.com
>>   for the original series posting.]

Paul, will you handle the patch or should it go through Samsung tree?

Best regards,
Krzysztof
