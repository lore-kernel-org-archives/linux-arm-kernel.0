From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Oct 2012 10:23:35 +0800
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <20121018222907.GH30550@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <CACRpkda0QLkdKns3CXNOijYBjaDtW1QyhNYjTqDvRH-in8pvZQ@mail.gmail.com>
 <20121018222907.GH30550@atomide.com>
Message-ID: <CAN1soZzsruhWt7VFgf5Fi79npcjLiMSUEVwnE3hR5iWEh+9GRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 6:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [121018 11:32]:
>> On Thu, Oct 18, 2012 at 11:07 AM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>>
>> > Add pinconf generic support with POWER SOURCE, BIAS PULL.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>>
>> I really like the looks of this, good job Haojian!
>>
>> Now we just need to hear what Tony says about it...
>
> Hey that's cool, maybe I'll find some use for those too :)
> I'll take a closer look tonigh or on Friday.
>
> Regards,
>
> Tony

I wonder whether gpio function in OMAP is also configured in the pinmux
register. For example, the function is 3bit field in pinmux register
of Marvell's
PXA/MMP silicon. GPIO function is the one of function.

If the usage case is same in OMAP silicon, I can merge
"pinctrl-single,gpio-mask"
with "pinctrl-single,function-mask".

Do we need "pinctrl-single,gpio-disable" at here? I want to remove it,
but I don't
know whether it's necessary in OMAP case.

Regards
Haojian
