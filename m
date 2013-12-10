From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 10:39:34 +0100
Subject: [PATCH 4/4] ARM: at91: localize GPIO header
In-Reply-To: <52A0AF7D.8020906@atmel.com>
References: <1383643826-14352-1-git-send-email-linus.walleij@linaro.org>
 <52A0AF7D.8020906@atmel.com>
Message-ID: <CACRpkdZcOTJqn1hEjDjgF_0cp4-Ab7Kq+3bC0nFfHFqmsLKoqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 5:53 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> 3.14 is a big release for us and I am sure that I will have to synchronize
> this patch with:
> - the other patches of this series: the one about serial driver
>   will probably be taken by Uwe.
> - the big cleanup modifications brought by the move to CCF
> - the initiative by Jean-Christophe to remove some of the
>   non-DT board files...
>
> Give me some time to see how I can integrate this into this 3.14 development
> phase...

OK I will keep my fingers away from AT91 for 3.14 so I don't
cause any mess through the GPIO or pinctrl tree. Let's revisit
this after the merge window and see what remains.

Yours,
Linus Walleij
