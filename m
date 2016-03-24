From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 25 Mar 2016 08:38:13 +0900
Subject: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
In-Reply-To: <56F3FBA7.9070702@fivetechno.de>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
 <56F3FBA7.9070702@fivetechno.de>
Message-ID: <56F47A65.6060401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 2016? 03? 24? 23:37, Markus Reichl wrote:
> Hi Chanwoo,
> 
> Am 24.03.2016 um 05:25 schrieb Chanwoo Choi:
>> Dear all,
>>
>> This patchset uses the DEVFREQ_TRANSITION_NOTIFIER notifier to connecth
>> devfreq device using ondemand governor and devfreq device using passive
>> governor. Also I fix the some issue reported by 'Tobias Jakobi' and add the
>> detailed issue information. But, this patchset don't modify the anything of
>> Device Tree patches (patch12 ~ patch21) which already got the reviewed-by
>> from Exynos Soc Maintainer.
>>
>> I tested it on exynos3250-rinato and exynos4412-odroidu3 board.
> 
> On exynos4412-odroidu3 board:
> 
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>


Thanks for your test.

Best Regards,
Chanwoo Choi

[snip]
