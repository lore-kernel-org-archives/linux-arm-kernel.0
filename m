From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Apr 2013 18:32:08 +0200
Subject: [PATCH] cpuidle: add maintainer entry
In-Reply-To: <CAL_Jsq+o1kF2GJNX5a01B9nPcq6uVLbpC-3RirU2uJAZ8C-jUg@mail.gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 <51781B48.30208@gmail.com> <5178D0EF.3090004@linaro.org>
 <CAKohpo=Ct7WCBSOqmgk8asVyXWa5o+jqpTwaQgxKVm_XNLfnMA@mail.gmail.com>
 <5178D5EF.9090102@linaro.org>
 <CAL_Jsq+o1kF2GJNX5a01B9nPcq6uVLbpC-3RirU2uJAZ8C-jUg@mail.gmail.com>
Message-ID: <51795A88.6020608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2013 05:50 PM, Rob Herring wrote:
> On Thu, Apr 25, 2013 at 2:06 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 04/25/2013 08:49 AM, Viresh Kumar wrote:
>>> On 25 April 2013 12:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>> On 04/24/2013 07:50 PM, Rob Herring wrote:
>>>
>>>>> Shouldn't MAINTAINERS contain the driver maintainers too?
>>>>
>>>> It should contains the upstream maintainer for the subsystem, and
>>>> optionally a co-maintainer.
>>>>
>>>> The MAINTAINERS file gives informations about the patch submission path.
>>>>
>>>> The file's header should contain the maintainer of the driver, so the
>>>> submitted patches will go to the subsystem maintainer for upstreaming
>>>> and to the driver maintainer for acked-by.
>>>>
>>>> If you add an entry in MAINTAINERS like:
>>>>
>>>> ARM/CALXEDA HIGHBANK ARCHITECTURE
>>>> M:      Rob Herring <rob.herring@calxeda.com>
>>>> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>> S:      Maintained
>>>> F:      arch/arm/mach-highbank/
>>>> +F:     drivers/cpuidle/cpuidle-calxeda.c
>>>>
>>>> That will add confusion while we are trying to clarify the situation
>>>> with a single entry point for the patches submission. If someone wants
>>>> to submit a patch for this driver, it will look at the MAINTAINERS file
>>>> and won't know if it should send the patch against arm-soc or linux-pm.
>>>
>>> I though otherwise. We can add entry in MAINTAINERS for any module.
>>> Module can be a framework/architecture or a single driver.
>>
>> IMO, there are too much drivers for that. It is simpler for someone to
>> read the MAINTAINERS file to find the cpuidle drivers goes through
>> linux-pm. I think we can trust Rafael to ask for the acked-by from the
>> maintainer of the driver before taking the patches.
> 
> It not a maintainer's job to solicit acks. It is the submitter's job
> to Cc the correct people. The maintainer should only check for
> necessary CC/acks and bitch at the submitter if they did not use
> get_maintainers.pl.

Ok, I was saying exactly the same, but it was misphrased.
I meant, we can be confident Rafael won't accept patches if they are not
acked by the correct people.

> Perhaps the MAINTAINERS file needs to be distributed to scale better
> or we need a way to put the maintainer data into the source and be
> usable by get_maintainers.pl.

Yep, the latter could be a good idea.

>>> Adding entry for cpuidle driver of a architecture as you wrote for calxeda is
>>> wrong as it adds to confusion and so there should be a separate entry for
>>> this driver rather than merging it with arch/ entries.
>>
>> Yes, actually it was an example to show the confusion we could be facing.
> 
> I'm confused about what is the confusion...



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
