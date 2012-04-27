From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 10:52:16 +0800
Subject: [PATCH] arm/pxa: fix gpio wakeup setting
In-Reply-To: <87ehrdhvkl.fsf@free.fr>
References: <CAN1soZyQPdcwRd5CtDz+iCV9h=Xq-ar=EBKyQ4ya_hE-PZLNXw@mail.gmail.com>
 <1335094644-3546-1-git-send-email-robert.jarzmik@free.fr>
 <87ehrdhvkl.fsf@free.fr>
Message-ID: <CAN1soZwPXEy9PDzfgh-tVp85hk+a5uYkG9_Q9T1Vovu8T-aWmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 1:46 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>
>> In 3.3, gpio wakeup setting was broken. The call
>> enable_irq_wake() didn't set up the PXA gpio registers
>> (PWER, ...) anymore.
>>
>> Fix it at least for pxa27x. The driver doesn't seem to be
>> used in pxa25x (weird ...), and the fix doesn't extend to
>> pxa3xx and pxa95x (which don't have a gpio_set_wake()
>> available).
>
> Haojian, ping.
> I'd like this to be included in 3.4, are you available nowadays ?
>
> Cheers.
>
> --
> Robert

Applied

Regards
Haojian
