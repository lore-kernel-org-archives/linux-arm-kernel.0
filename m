From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Nov 2012 09:34:45 -0800
Subject: [PATCH v4 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <CACRpkdYRvEzTr6kOE6XYmrKiztJ0F+HUFCv8Jd+m2c-AOFooAw@mail.gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-10-git-send-email-haojian.zhuang@gmail.com>
 <20121108012550.GV6801@atomide.com>
 <CACRpkdYRvEzTr6kOE6XYmrKiztJ0F+HUFCv8Jd+m2c-AOFooAw@mail.gmail.com>
Message-ID: <20121113173444.GB6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [121113 05:10]:
> On Thu, Nov 8, 2012 at 2:25 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:22]:
> >> Dump pinmux register value, not only function part in the pinmux
> >> register.
> >>
> >> Also fix the issue on caluclating pin offset. The last parameter
> >> should be pin number, not register offset.
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Shall I apply this to the pinctrl tree?

Yes please.

Regards,

Tony
