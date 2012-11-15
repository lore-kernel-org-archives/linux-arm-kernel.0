From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 15:11:53 +0100
Subject: [PATCH v4 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <CAN1soZxSQb2RN41v64SuOaQ6eLcV5NEZWSsMBBb_84dd5xks6Q@mail.gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-10-git-send-email-haojian.zhuang@gmail.com>
 <20121108012550.GV6801@atomide.com>
 <CACRpkdYRvEzTr6kOE6XYmrKiztJ0F+HUFCv8Jd+m2c-AOFooAw@mail.gmail.com>
 <20121113173444.GB6801@atomide.com>
 <CAN1soZxSQb2RN41v64SuOaQ6eLcV5NEZWSsMBBb_84dd5xks6Q@mail.gmail.com>
Message-ID: <CACRpkdbAhKv8d6wdr-HYsgtNV5ax7go4OpeVmb5vQjKTDqusmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 2:45 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Wed, Nov 14, 2012 at 1:34 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Linus Walleij <linus.walleij@linaro.org> [121113 05:10]:
>>> On Thu, Nov 8, 2012 at 2:25 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> > * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:22]:
>>> >> Dump pinmux register value, not only function part in the pinmux
>>> >> register.
>>> >>
>>> >> Also fix the issue on caluclating pin offset. The last parameter
>>> >> should be pin number, not register offset.
>>> >
>>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Shall I apply this to the pinctrl tree?
>>
>> Yes please.
>>
>> Regards,
>>
>> Tony
>
> Yes, this patch doesn't impact others. Please help to merge.

OK patch applied to the pinctrl tree.

Yours,
Linus Walleij
