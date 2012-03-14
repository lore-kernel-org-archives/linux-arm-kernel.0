From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Mar 2012 14:24:50 -0700
Subject: [PATCH 00/12] mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC
 card detect
In-Reply-To: <4F61072B.9030606@ti.com> (Benoit Cousson's message of "Wed, 14
 Mar 2012 22:01:31 +0100")
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <87399ahppf.fsf@ti.com> <4F61072B.9030606@ti.com>
Message-ID: <87ty1qeuzh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 3/14/2012 9:50 PM, Kevin Hilman wrote:
>> Hi Benoit,
>>
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>> [...]
>>
>>> This is not for pull-request, becasue it is based on irqdomain + OMAP
>>> IRQ DT series + OMAP twl DT series yet to be pushed.
>>
>> What's the status of this series?
>
> I sent earlier today the pull request to Samuel.
>
> Here is the branch for information: for_3.4/twl_irq_gpio_mmc_fix
>
>> At least 'gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ
>> support' is needed in mainline (linux-next) now since without it, non-DT
>> boots will dump a big fat warning trace[2].
>
> Yeah, I know :-(
>
>> Also FYI, I needed the patch below[1] in order to build this series.
>
> That's weird, this include was added by the following commit
> a7cbb9b15d55dff0488b1a6d93929c2386d8632b at 3.2 time frame.

OK.

> What branch are you using?

I was using your for_3.4/twl_irq_gpio_cleanup, but had some merge
conflicts.  Maybe I mis-merged something and dropped that include.

Kevin
