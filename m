From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 25 Jan 2013 18:00:04 +0800
Subject: [PATCH 02/10] gpio: pxa: identify ed mask reg with platform data
In-Reply-To: <CACRpkdb8iQiSJZKe5ViGc08LJP686KmP2J8Z=GsbhjYkyvXF_g@mail.gmail.com>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-3-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdYnMhWYy_FGrJs+=DN7od08nk5eeansPNaq9nxhm61-=A@mail.gmail.com>
 <CACRpkdb8iQiSJZKe5ViGc08LJP686KmP2J8Z=GsbhjYkyvXF_g@mail.gmail.com>
Message-ID: <CAN1soZwGDWrNERq4bKcRGpWmq2HZ0yiOdx40f-tBd37yM4hT4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 5:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jan 25, 2013 at 10:54 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>>> Avoid to judge whether edge mask register exists by CPU. Use platform
>>> data to identify it instead. The gpio edge mask register exists in MMP
>>> series SoC.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> ARM SoC folks: do you approve (ACK) this patch so I
>> can apply it to my GPIO tree?
>>
>> It looks allright to me, I just want to know so that there are no
>> huge changes around this code in the ARM SoC tree that will
>> cause trouble.
>
> Actually this goes for the whole series.
>
> It touches a lot of code in arch/arm/*
>
> Haoijan, do you prefer if ACK it so you can take it up through
> ARM SoC?
>
> I'm OK to take it all through my GPIO tree as well if the
> ARM people ACK them.
>

I'm fine to merge into gpio git tree.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
