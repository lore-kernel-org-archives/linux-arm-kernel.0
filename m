From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 19 Nov 2013 10:25:41 +1100
Subject: [GIT PULL] ep93xx-devel for 3.12
In-Reply-To: <CAOesGMjVUd5EKPPU5sahaSTUasRF2dqGO6eyoUM7yyrEx6rkrg@mail.gmail.com>
References: <522FB619.90603@gmail.com>	<CAOesGMg8utb11JQpbJGAMNmvdGtz2+DbUfCmbXBNj0Gpw+2vAA@mail.gmail.com>	<522FD8B1.4080206@gmail.com>	<528A90DA.7020803@gmail.com>
 <CAOesGMjVUd5EKPPU5sahaSTUasRF2dqGO6eyoUM7yyrEx6rkrg@mail.gmail.com>
Message-ID: <528AA1F5.4010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/13 10:15, Olof Johansson wrote:
> On Mon, Nov 18, 2013 at 2:12 PM, Ryan Mallon <rmallon@gmail.com> wrote:
>> On 11/09/13 12:42, Ryan Mallon wrote:
>>> On 11/09/13 12:22, Olof Johansson wrote:
>>>> Hi Ryan,
>>>>
>>>> On Tue, Sep 10, 2013 at 5:15 PM, Ryan Mallon <rmallon@gmail.com> wrote:
>>>>> Hi Arnd, Olof,
>>>>>
>>>>> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>>>>>
>>>>>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-devel-for-3.12
>>>>>
>>>>> for you to fetch changes up to 0e98a32f8773993da65ab4759b0c5ba362119ebb:
>>>>>
>>>>>   arm: ep93xx: use soc bus (2013-07-19 10:08:15 +1000)
>>>>
>>>>
>>>> Unfortunately the merge window is already in progress, and we're not
>>>> taking new code into arm-soc for 3.12. We ask that platform
>>>> maintainers send us the code they want into the next release by -rc6
>>>> or -rc7 the latest, so we have some time to merge it and sort it out
>>>> if needed, and so that it has time to sit in linux-next to discover
>>>> any problems.
>>>
>>> Ugh, my fault sorry. I'm slack on keeping up with the merge windows.
>>>
>>>> So, please resend this pull request once 3.12-rc1 is out, and we'll be
>>>> happy to queue it up for 3.13 inclusion!
>>
>> Hi Olof,
>>
>> Is it possible to get this pulled now for 3.13? I haven't modified the
>> branch at all, and there is still just the one commit there. I can't
>> fast-forward the tree, and don't want to rebase it, but it should merge
>> cleanly as-is I think.
>>
>> I also have an ep93xx-fixes branch with one commit on it for 3.13.
>> Unfortunately I've neglected the branch and so it's history looks like:
>>
>>   337f9c21 ARM: ep93xx: remove deprecated IRQF_DISABLED
>>   cc3874fe ARM: ep93xx: Don't use modem interface on the second UART
>>   ad81f054 Linux 3.11-rc1
>>
>> The cc3874fe commit was already merged for 3.12, and the branch won't
>> let me fast-forward on to, say v3.12-rc7. Should I rebase the 337fc21
>> commit onto the latest mainline tag, or do I just do a pull request with
>> cc3874fe as the base tag?
>>
>> Sorry for the annoyance. I get so few patches via this tree, and I don't
>> even have hardware ep93xx set up at the moment. I don't keep up with the
>> merge window status very well, and its unfair to the people who's
>> patches I am carrying. Is there an arm-soc-misc tree future patches
>> could go via, or Hartley might be interested in taking over the tree?
> 
> 
> We're definitely open to applying patches directly, ideally either by
> you acking them or by you applying/testing them and then sending them
> on to us (at arm at kernel.org).
> 
> In this case, for this fix, just send the patch over with your S-o-b
> on it and I'll apply it. Likewise I'll queue up the previous branch
> for 3.14 as soon as the merge window is over so that it'll find its
> way in for 3.14.

I've sent both patches I had, one from this branch (ep93xx-devel) and
the other from ep93xx-fixes to arm at kernel.org. If you grab both of
those, then you can ignore this pull request.

btw, did you mean inclusion for 3.13 rather than 3.14? Both of these
patches have been in linux-next for a while (too long).

Thanks,
~Ryan
