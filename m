From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 08 Sep 2014 13:15:46 -0400
Subject: [PATCH v2 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
In-Reply-To: <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
 <1409957256-23729-16-git-send-email-sboyd@codeaurora.org>
 <CAKohpokLFMMK-h2657=_BCBr3oXCTiQDA+C-rDgorxfrPR-9YQ@mail.gmail.com>
Message-ID: <540DE442.6060505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2014 12:46 AM, Viresh Kumar wrote:
> On 6 September 2014 04:17, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
>> new file mode 100644
>> index 000000000000..aa8eb97144b6
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq.c
>> @@ -0,0 +1,199 @@
>> +/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
> 
> Shouldn't this have Qcom instead?

No. The copyright has been transferred.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
