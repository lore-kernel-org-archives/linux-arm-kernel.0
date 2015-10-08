From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 08 Oct 2015 12:45:58 +0530
Subject: [PATCH v3 5/9] thermal: qcom: tsens-8960: Add support for 8960
 family of SoCs
In-Reply-To: <20151008061243.GE26883@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-6-git-send-email-rnayak@codeaurora.org>
 <20151008061243.GE26883@codeaurora.org>
Message-ID: <5616182E.5060707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/2015 11:42 AM, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
>> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
>> index a471100..f3cefd1 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -1,2 +1,2 @@
>>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o
>> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o
> 
> Maybe a dumb question: What's the point of multiple files for
> each SoC if they're always built?

Just for code segregation and better readability.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
