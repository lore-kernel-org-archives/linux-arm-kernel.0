From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Apr 2013 09:06:23 +0200
Subject: [PATCH] cpuidle: add maintainer entry
In-Reply-To: <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 <51781B48.30208@gmail.com> <5178D0EF.3090004@linaro.org>
 <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
Message-ID: <5178D5EF.9090102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2013 08:49 AM, Viresh Kumar wrote:
> On 25 April 2013 12:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 04/24/2013 07:50 PM, Rob Herring wrote:
> 
>>> Shouldn't MAINTAINERS contain the driver maintainers too?
>>
>> It should contains the upstream maintainer for the subsystem, and
>> optionally a co-maintainer.
>>
>> The MAINTAINERS file gives informations about the patch submission path.
>>
>> The file's header should contain the maintainer of the driver, so the
>> submitted patches will go to the subsystem maintainer for upstreaming
>> and to the driver maintainer for acked-by.
>>
>> If you add an entry in MAINTAINERS like:
>>
>> ARM/CALXEDA HIGHBANK ARCHITECTURE
>> M:      Rob Herring <rob.herring@calxeda.com>
>> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> S:      Maintained
>> F:      arch/arm/mach-highbank/
>> +F:     drivers/cpuidle/cpuidle-calxeda.c
>>
>> That will add confusion while we are trying to clarify the situation
>> with a single entry point for the patches submission. If someone wants
>> to submit a patch for this driver, it will look at the MAINTAINERS file
>> and won't know if it should send the patch against arm-soc or linux-pm.
> 
> I though otherwise. We can add entry in MAINTAINERS for any module.
> Module can be a framework/architecture or a single driver.

IMO, there are too much drivers for that. It is simpler for someone to
read the MAINTAINERS file to find the cpuidle drivers goes through
linux-pm. I think we can trust Rafael to ask for the acked-by from the
maintainer of the driver before taking the patches.

> Adding entry for cpuidle driver of a architecture as you wrote for calxeda is
> wrong as it adds to confusion and so there should be a separate entry for
> this driver rather than merging it with arch/ entries.

Yes, actually it was an example to show the confusion we could be facing.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
