From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 3 Sep 2012 19:50:55 +0800
Subject: [PATCH 1/3] ARM: PRIMA2: add missing interrupts property for
 pinctrl node
In-Reply-To: <CACRpkdaNhas-xLC18Dow95vv=arq9MudF0s0xsZPLJZ++syfXQ@mail.gmail.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
 <1345690074-31327-2-git-send-email-Barry.Song@csr.com>
 <CACRpkdaNhas-xLC18Dow95vv=arq9MudF0s0xsZPLJZ++syfXQ@mail.gmail.com>
Message-ID: <CAGsJ_4zzcg92OVDS0G8UkHBJ21o5zSWHS5f_sHcyudAABwHnPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/3 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Aug 23, 2012 at 4:47 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> commit 5130216265f6f924a4 missed the interrupts property
>>
>> Signed-off-by: Barry Song <Barry.Song@csr.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I expect that you take this patch through the ARM SoC tree?
>
> If you want me to carry it in the pinctrl tree, tell me.

thanks a lot, linus! taking these through ARM SoC tree is the best way
to avoid possible conflict.
i have not done that in prima2 common clk driver, then i have a
strange pull request:
http://www.spinics.net/lists/arm-kernel/msg191412.html

>
> Yours,
> Linus Walleij
>

-barry
