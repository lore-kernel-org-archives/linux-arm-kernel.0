From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Sep 2012 22:03:20 +0200
Subject: [RFC PATCH 0/6] pinctrl: samsung: Convert the driver to use
 per-bank GPIO and interrupt specifiers
In-Reply-To: <CAH9JG2V+Ju0wFCJZZieNpK+1pDJ1zGwNSS=j4dV0hVtHXQmb5w@mail.gmail.com>
References: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
 <CACRpkdaqaaNf=S9CMzYE3zpji0pCK1MLKeBm3uH7-18HHwPV3w@mail.gmail.com>
 <CAH9JG2V+Ju0wFCJZZieNpK+1pDJ1zGwNSS=j4dV0hVtHXQmb5w@mail.gmail.com>
Message-ID: <CACRpkdb4Hp+zXKfufR0aJcJFvcNH=JYQeTUzaZEafxSVN5f3-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 12:45 PM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> On 9/24/12, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Sep 21, 2012 at 4:22 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>>
>>> This is a continuation of work focused on improving the pinctrl-samsung
>>> driver.
>>
>> All look good to me, I guess these will go through the Samsung tree?
>> Acked-by: Linus Walleij <linus.walleij@linaro.org> for all.
>
> Now samsung tree is merged so if you don't mind, can you merge it by
> pinctl tree?

Yes but not until after the merge window... I have closed my
tree.

I think all dependencies are in the ARM SoC tree now, so I
suspect it wouldn't apply anyway?

Tomasz can you repost this after the merge window so I don't
forget about applying it?

Yours,
Linus Walleij
