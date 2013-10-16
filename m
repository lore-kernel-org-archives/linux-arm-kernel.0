From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Oct 2013 18:35:24 +0200
Subject: [RESEND] cpuidle for ARM pull request
In-Reply-To: <2224191.VjCA0rsPcU@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <1598661.FpX5cmjM1U@vostro.rjw.lan>
 <51F3650B.8080708@linaro.org> <2224191.VjCA0rsPcU@vostro.rjw.lan>
Message-ID: <525EC04C.8020507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2013 02:37 PM, Rafael J. Wysocki wrote:
> On Saturday, July 27, 2013 08:13:31 AM Daniel Lezcano wrote:
>> On 07/26/2013 02:07 AM, Rafael J. Wysocki wrote:
>>> On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
>>>> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
>>>>> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
>>>>>> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
>>>>>>>

[ ... ]

> Next time, can you please add a general description of what the patches do and
> why they do that to the pull request?
>
>> I thought it would have been easier for us if I could based my PRs on
>> top of your linux-next branch, so acting as a proxy for ARM patches. I
>> am maintaining the clocksource drivers and I am basing my tree on top of
>> tip/core.
>>
>> I guess you are rebasing your tree often and this is an issue for you,
>> right ?
>
> Yes, my linux-next branch may contain commits that will be modified later
> (e.g. ACKs added, fixes folded in etc.).
>
> Anyway, as I said, as long as the material you have for me doesn't depend on
> anything new in my tree, it's better to base it on top of an -rc kernel.
>
> In case it does depend on that, I've put the entire outstanding cpuidle
> material into my pm-cpuidle branch (including your ARM commits just pulled).

Hi Rafael,

is it possible to update the pm-cpuidle branch ? so I can base my pull 
request on it. There will be a (trivial) conflict in the Makefile and 
Kconfig.arm if I base my PR on v3.12-rc5.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
