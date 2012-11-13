From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Nov 2012 14:08:31 +0100
Subject: [PATCH v4 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <20121108012550.GV6801@atomide.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-10-git-send-email-haojian.zhuang@gmail.com>
 <20121108012550.GV6801@atomide.com>
Message-ID: <CACRpkdYRvEzTr6kOE6XYmrKiztJ0F+HUFCv8Jd+m2c-AOFooAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 2:25 AM, Tony Lindgren <tony@atomide.com> wrote:

> * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:22]:
>> Dump pinmux register value, not only function part in the pinmux
>> register.
>>
>> Also fix the issue on caluclating pin offset. The last parameter
>> should be pin number, not register offset.
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I apply this to the pinctrl tree?

Yours,
Linus Walleij
