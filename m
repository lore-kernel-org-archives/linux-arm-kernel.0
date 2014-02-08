From: dianders@chromium.org (Doug Anderson)
Date: Fri, 7 Feb 2014 16:51:37 -0800
Subject: [PATCH v2 00/12] Samsung PM consolidation part 2 (multiplatform)
In-Reply-To: <52F57372.7010507@gmail.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
 <20140207221537.GA12714@quad.lixom.net>
 <52F57372.7010507@gmail.com>
Message-ID: <CAD=FV=UPH4vf2-5GuOypkkbMsDPmM7dPZJtFpHs+wBsN0wy8=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Fri, Feb 7, 2014 at 3:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
>
> On 07.02.2014 23:15, Olof Johansson wrote:
>>
>> On Thu, Feb 06, 2014 at 08:12:45PM +0100, Tomasz Figa wrote:
>>
>>> On Exynos4210-based Trats, Exynos4412-based Trats2 and Exynos5250-based
>>> Arndale boards (except suspend/resume, which is broken because of
>>> unrelated reasons):
>>
>>
>> Has this been reported, and is it being worked on by anyone?
>
>
> Yes, reported quite a long time ago by Vikas Sajjan of Samsung/Linaro, but
> I'm not sure if anybody is working to fix it.
>
> I've been looking into this for a while, but couldn't really find anything
> except that it hangs when PMU starts power state transtion after CPU
> executing WFI instruction.

It's likely it's something else, but just in case I'll point you to a
bug that we fixed that had the same symptom.  There's some details
(and a lot of noise) in <http://crbug.com/218132>.  ...or maybe just
look at the root cause at <http://crosreview.com/42067>.

-Doug
