From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 12 Jan 2015 17:39:28 +0900
Subject: [PATCHv7 04/10] devfreq: event: Add exynos-ppmu devfreq-event
 driver
In-Reply-To: <603055177.891931421049871049.JavaMail.weblogic@epmlwas09a>
References: <603055177.891931421049871049.JavaMail.weblogic@epmlwas09a>
Message-ID: <54B38840.9080308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 01/12/2015 05:04 PM, MyungJoo Ham wrote:
>>   
>>  This patch adds exynos-ppmu devfreq-event driver to get performance data
>> of each IP for Samsung Exynos SoC. These event from Exynos PPMU provide
>> useful information about the behavior of the SoC that you can use when
>> analyzing system performance, and made visible and can be counted using
>> logic in each IP.
>>
>> This patch is based on existing drivers/devfreq/exynos/exynos-ppmu.c
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/event/Kconfig       |   9 +
>>  drivers/devfreq/event/Makefile      |   1 +
>>  drivers/devfreq/event/exynos-ppmu.c | 399 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 409 insertions(+)
>>  create mode 100644 drivers/devfreq/event/exynos-ppmu.c
>>
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 

Thanks for your reviw.

Best Regards,
Chanwoo Choi
