From: khilman@ti.com (Kevin Hilman)
Date: Wed, 23 Nov 2011 12:01:46 -0800
Subject: [PATCH/RESEND #3 1/7] OMAP3+: PM: SR: add suspend/resume handlers
In-Reply-To: <CAOMWX4egSeBfHdD4LHxtvvaQj+MK0ecRrQGdQ+ELDRUz5tFUEg@mail.gmail.com>
 (Nishanth Menon's message of "Fri, 18 Nov 2011 18:35:53 -0600")
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-2-git-send-email-balbi@ti.com>
 <87vcqj62gd.fsf@ti.com>
 <CAOMWX4egSeBfHdD4LHxtvvaQj+MK0ecRrQGdQ+ELDRUz5tFUEg@mail.gmail.com>
Message-ID: <87ty5ua9qt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, Nov 16, 2011 at 18:02, Kevin Hilman <khilman@ti.com> wrote:
>> Felipe Balbi <balbi@ti.com> writes:
>>
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> SmartReflex should be disabled while entering low power mode due to
>>> the following reasons:
>> [...]
>>
>> Nishanth, in the end, didn't you decide to drop this patch?
>>
>
> Yes, I did eventually, once we implemented DVFS for GPU, Ducati, HSI,
> and other drivers, there was no real way to ensure sequence of suspend
> sequencing even after moving this to suspend_noirq. some of the other
> reasons:

OK, thanks for the clarification.

Kevin
