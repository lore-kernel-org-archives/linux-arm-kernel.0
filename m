From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 3 Jul 2012 13:12:48 +0800
Subject: [PATCH] ARM: u300: convert to common clock
In-Reply-To: <CAJOA=zPK64oEp7Yo9+3gqssPOM0yvzF738N4_ZL0cjh2QFTV-A@mail.gmail.com>
References: <1340142265-14549-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdakK9LPfZa8zWCE415GLc_n+tPqGJPQr6g1O2K0ptd-UA@mail.gmail.com>
 <CAJOA=zPK64oEp7Yo9+3gqssPOM0yvzF738N4_ZL0cjh2QFTV-A@mail.gmail.com>
Message-ID: <CAGsJ_4y0JabhNqpu840XvKgtPoHdQh5rC-cP7Eqjc5zhcH8SvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/3 Turquette, Mike <mturquette@ti.com>:
> On Sat, Jun 30, 2012 at 12:50 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Tue, Jun 19, 2012 at 11:44 PM, Linus Walleij
>> <linus.walleij@stericsson.com> wrote:
>>
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> This converts the U300 clock implementation over to use the common
>>> struct clk and moves the implementation down into drivers/clk.
>>> Since VCO isn't used in tree it was removed, it's not hard to
>>> put it back in if need be.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Mike if this looks allright, could you merge it into the clk-next branch?
>
> With a negative diff of 805 lines, who could say 'no' to this patch?
> But seriously the changes do look good.  I fixed up a small conflict
> in the clk Makefile due to your earlier integrator/icst patches.  The
> only other thing is that some of the headers included in
> drivers/clk/clk-u300.c are unnecessary.  I hate blocking a patch on
> such trivial stuff, but maybe you could clean that up down the road
> some day?  For now I've taken it into clk-next.
>

i'll merge clk-next and linus' this patch to prima2 common-clk branch
and have a prima2 common-clk driver.

> Thanks,
> Mike
>
>>
>> Yours,
>> Linus Walleij


-barry
