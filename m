From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 27 May 2014 17:33:51 +0530
Subject: [PATCH 1/1] ARM: mvebu: Staticize local variables
In-Reply-To: <20140527140149.177dc810@free-electrons.com>
References: <1401190629-24559-1-git-send-email-sachin.kamat@linaro.org>
 <20140527135108.1642833b@free-electrons.com>
 <CAK9yfHxm27Rg3YcXTfSff7LAmYsj-VFBgBKXBXiD8SXGGYfFzQ@mail.gmail.com>
 <20140527140149.177dc810@free-electrons.com>
Message-ID: <CAK9yfHymhviBqOEEVHyNnbKxMCom58YL2o9ThwxFKGjBcPQs0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2014 17:31, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Sachin Kamat,
>
> On Tue, 27 May 2014 17:24:10 +0530, Sachin Kamat wrote:
>
>> >>       unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
>> >>       u32 reg;
>> >> @@ -263,7 +263,7 @@ static struct notifier_block
>> >> armada_370_xp_cpu_pm_notifier = { .notifier_call =
>> >> armada_370_xp_cpu_pm_notify, };
>> >>
>> >> -int __init armada_370_xp_cpu_pm_init(void)
>> >> +static int __init armada_370_xp_cpu_pm_init(void)
>> >
>> > Indeed, this one needs to be fixed.
>>
>> How do you want me to handle this?
>
> Maybe send a new patch that fixes just that one?

Sounds good. Thanks.

-- 
With warm regards,
Sachin
