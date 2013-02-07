From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Feb 2013 20:10:38 +0100
Subject: [PATCH 09/14] pinctrl/abx500: use direct IRQ defines
In-Reply-To: <CAF2Aj3jHe+mP0dU_BHThBV-va_iJLcFQedmWQOTaYafAZM1Yxg@mail.gmail.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-10-git-send-email-linus.walleij@stericsson.com>
 <5112F1B9.6010700@wwwdotorg.org>
 <CAF2Aj3jHe+mP0dU_BHThBV-va_iJLcFQedmWQOTaYafAZM1Yxg@mail.gmail.com>
Message-ID: <CACRpkdYCqU0srgiboJnOTaOiG+9BCk-Kbe0-jscMMcnyKnVUDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 10:01 AM, Lee Jones <lee.jones@linaro.org> wrote:

> I don't see myself on cc. Was that intentional?

No, it was my mistake...

> I quite like the idea of this.

Can I take it as an ACK? :-)

> Stephen,
>
> It doesn't mean the other patch was wrong, it just transfers the math.
>
> I wouldn't squash it into mine. I like the transition and the possibility to
> revert it if there's been some mistake.
>
> (not to say there is one, but just in case.)

I don't think it's wrong, just different. I changed
it after trying to subtract the offset in my head back
and forth a few times and screwed up the maths.

Yours,
Linus Walleij
