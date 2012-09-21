From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Fri, 21 Sep 2012 10:40:44 +0530
Subject: [PATCH] serial: omap: Remove unnecessary checks from
 suspend/resume
In-Reply-To: <87r4pxelje.fsf@deeprootsystems.com>
References: <1347968154-27997-1-git-send-email-sourav.poddar@ti.com>
 <20120918113444.GG24047@arwen.pp.htv.fi>
 <CAKdam56UKpc3icL7J7+Om=5Qk_P4ckWM+XY5E+GFvXieAAxjyA@mail.gmail.com>
 <87r4pxelje.fsf@deeprootsystems.com>
Message-ID: <CAKdam57u8qdOhgtgjgQG3r=eFB_Wsd54KzLoAtPj9GcHLz2E5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Sep 20, 2012 at 3:13 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Poddar, Sourav" <sourav.poddar@ti.com> writes:
>
>> Hi Felipe,
>>
>> On Tue, Sep 18, 2012 at 5:04 PM, Felipe Balbi <balbi@ti.com> wrote:
>>> On Tue, Sep 18, 2012 at 05:05:54PM +0530, Sourav Poddar wrote:
>>>> Drop the check for "up" being valid on suspend/resume callbacks.
>>>> It should be valid always. Get rid of the "pdata" check also as
>>>> serial_omap_get_context_loss_count() checks for it.
>>>>
>>>> Tested on omap4 panda and 3630 based Beagle board.
>>>
>>> you need a blank line here. Other than that:
>>>
>>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>>>
>>> ps: what kind of tests did you run, btw ?
>>>
>> Boot tested on Panda.
>> Boot and PM tested(hitiing Off) on Beagle.
>
> What does "PM tested" mean.  hitting off in idle?  hitting off in
> suspend?  both?
>
Hitting off in both idle and suspend.
> Please clarify.
>
> Thanks,
>
> Kevin
~Sourav
