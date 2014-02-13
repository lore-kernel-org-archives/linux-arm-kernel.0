From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Feb 2014 08:07:36 +0900
Subject: [PATCH v2 7/9] clk: samsung: Drop old suspend/resume code
In-Reply-To: <4274393.fPXjFZLa78@phil>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
 <1391710616-14226-8-git-send-email-t.figa@samsung.com>
 <4274393.fPXjFZLa78@phil>
Message-ID: <52FD5038.6090309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/14 18:50, Heiko St?bner wrote:
> Am Donnerstag, 6. Februar 2014, 19:16:54 schrieb Tomasz Figa:
>> Since all SoC drivers have been moved to local suspend/resume handling,
>> the old code can be safely dropped.
>>
>> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
>> Acked-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> So it looks like I'll need to respin my s3c24xx-ccf patches again, but
> nevertheless:
>
> Acked-by: Heiko Stuebner<heiko@sntech.de>
>

Heiko,

I'll apply this series, so please re-work your s3c24xx CCF based on 
this. you can see in v3.15-next/s2r-pm-samsung.

Thanks,
- Kukjin

>> ---
>>   drivers/clk/samsung/clk-exynos4.c    |  2 +-
>>   drivers/clk/samsung/clk-exynos5250.c |  2 +-
>>   drivers/clk/samsung/clk-exynos5420.c |  2 +-
>>   drivers/clk/samsung/clk-exynos5440.c |  2 +-
>>   drivers/clk/samsung/clk-s3c64xx.c    |  2 +-
>>   drivers/clk/samsung/clk.c            | 54
>> +----------------------------------- drivers/clk/samsung/clk.h            |
>>   4 +--
>>   7 files changed, 7 insertions(+), 61 deletions(-)
