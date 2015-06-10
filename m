From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Wed, 10 Jun 2015 11:37:52 +0800
Subject: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <1433841449.16887.58.camel@x220>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
 <1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
 <1433841449.16887.58.camel@x220>
Message-ID: <CALx668WP6Z-bU3_ZX1Ujb=MV_QGA6HdTg8ycUYTqWJ1xtp-Hiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 5:17 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Mon, 2015-06-08 at 20:29 +0800, Pi-Cheng Chen wrote:
>> --- /dev/null
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>
>> +#include <linux/module.h>
>
> Weren't you going to drop this include?

Sorry I forget to merge that part of fix into this patch.
Will fix it.

>
>> +module_init(mt8173_cpufreq_driver_init);
>
> For built-in code this is equivalent to, speaking from memory:
>     device_initcall(mt8173_cpufreq_driver_init);
>
> Why don't you just use that directly?

Yes. Will do it.
Thanks for reviewing.

Best Regards,
Pi-Cheng

>
> Thanks,
>
>
> Paul Bolle
>
