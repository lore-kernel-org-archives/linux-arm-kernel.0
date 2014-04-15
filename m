From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 15 Apr 2014 14:36:15 +0530
Subject: [PATCH 2/6] ARM: EXYNOS: Staticize exynos_subsys
In-Reply-To: <CAK9yfHw9fga+1kOo5tpW37wskZEQarrABiyZD+SBzBwk1h6DbQ@mail.gmail.com>
References: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
 <1397118296-6846-3-git-send-email-sachin.kamat@linaro.org>
 <534661C7.9090304@samsung.com>
 <CAK9yfHwAM0d5JsrhKGP0gkrjQLxGFE0+oEjv26N5jsFnvYku9A@mail.gmail.com>
 <53468F44.3050109@samsung.com>
 <CAK9yfHw9fga+1kOo5tpW37wskZEQarrABiyZD+SBzBwk1h6DbQ@mail.gmail.com>
Message-ID: <CAK9yfHxwTo1WPPS7asJOMAVSK5=3ufFrLuB9mYyT8t-CgMxGWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 10 April 2014 18:05, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 10 April 2014 18:02, Tomasz Figa <t.figa@samsung.com> wrote:
>> On 10.04.2014 11:22, Sachin Kamat wrote:
>>>
>>> Hi Tomasz,
>>>
>>> On 10 April 2014 14:47, Tomasz Figa <t.figa@samsung.com> wrote:
<snip>
>> Hmm, I don't see why it could break anything as I can't find any users of
>> it. Anyway I just tested removing this code on Exynos4412-trats2 board and
>> didn't find any problems.
>
> Thanks for testing. Let me check at my end on other boards and if it
> doesn't cause
> any problem, will remove this.

Tested after removing this code on various boards and there doesn't
seem to be any
problems. Will re-send with this change.

-- 
With warm regards,
Sachin
