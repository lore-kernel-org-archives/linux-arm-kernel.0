From: js1304@gmail.com (JoonSoo Kim)
Date: Thu, 7 Feb 2013 00:08:08 +0900
Subject: [PATCH RESEND] ARM: sched: correct update_sched_clock()
In-Reply-To: <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
References: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
 <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
Message-ID: <CAAmzW4NKuWUJtO_K0GMxBMDo4Y4JNpMBp=fLsJfBNhTzUuHZPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Linus.

2013/2/6 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Feb 6, 2013 at 6:21 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
>
>> If we want load epoch_cyc and epoch_ns atomically,
>> we should update epoch_cyc_copy first of all.
>> This notify reader that updating is in progress.
>
> If you think the patch is finished, put it into Russell's patch tracker:
> http://www.arm.linux.org.uk/developer/patches/

Ah... Okay.
Thanks for notifying me.
