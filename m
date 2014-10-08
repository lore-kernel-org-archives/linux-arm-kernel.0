From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 8 Oct 2014 11:57:07 +0200
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybiZQgok1oa3aar0ymgfu8KUn1j3LLqHiwQ81Mnh8zVHXQ@mail.gmail.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybjP1WQfbyWR5GwQ6QnUjsy4qB_678+L=jgmMzz-rWkb0w@mail.gmail.com>
 <016401cfe2d3$23f3f0c0$6bdbd240$@kernel.org>
 <CAGm_ybiZQgok1oa3aar0ymgfu8KUn1j3LLqHiwQ81Mnh8zVHXQ@mail.gmail.com>
Message-ID: <CABxcv=k==kP_+fc58a6ji_O572Cxzj_EmxmRo3kbc48k-qBO-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

On Wed, Oct 8, 2014 at 11:26 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>>>
>>> Can you please pick this series.
>>>
>> Yes, sure I will queue this series after -rc1 release.
>

Not related to your series but did you figure out why the
aclk200_disp1 and aclk300_disp1 clocks are left unused?

I'm carrying your patch to flag those clocks as CLK_IGNORE_UNUSED to
prevent being disabled by the CCF. And while that allows me to test,
I'm afraid that it may not be the proper solution since it could just
be hiding the real cause of the issue.

Of course this should not block your series from been merged but I
just wondered if you found the cause since it would be nice to have
s2r properly working on exynos5420.

> Thank you.
>
>>
>> Thanks,
>> Kukjin
>>

best regards,
Javier
