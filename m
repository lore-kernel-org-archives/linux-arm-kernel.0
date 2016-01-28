From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 28 Jan 2016 19:50:41 +0900
Subject: [PATCH v6 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <56A9F205.1060302@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
 <20151216021446.GC3111@ubuntu> <56A9F205.1060302@samsung.com>
Message-ID: <56A9F281.2080906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.01.2016 19:48, Krzysztof Kozlowski wrote:
> On 16.12.2015 11:14, Viresh Kumar wrote:
>> On 15-12-15, 18:33, Bartlomiej Zolnierkiewicz wrote:
>>> Hi,
>>>
>>> This patch series adds generic cpufreq-dt driver support for
>>> Exynos542x/5800 (using the new CPU clock type which allows it).
>>>
>>> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
>>>
>>> Depends on:
>>> - next-20151211 branch of linux-next kernel tree
>>> - "[PATCH] ARM: dts: Make CPU configuration more readable for
>>>   exynos542x/5800" patch (https://lkml.org/lkml/2015/12/11/107)
>>>
>>> Changes since v5:
>>> - rebased over next-20151211 branch (something is broken in
>>>   newer branches, namely next-2015121[45])
>>> - rebased on top of "ARM: dts: Make CPU configuration more
>>>   readable for exynos542x/5800" patch
>>> - renamed cpu0_opp_table to cluster_a15_opp_table and
>>>   cpu1_opp_table to cluster_a7_opp_table
>>> - added Reviewed-by from Krzysztof
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Applied entire patchset to my krzk repo.

Wrong. Applied only Exynos part, which is DTS + mach-exynos. The clock
stuff was already in v4.5-rc1.

Best regards,
Krzysztof
