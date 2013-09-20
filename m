From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 23:09:48 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring take 2
In-Reply-To: <1379708226-7802-1-git-send-email-linus.walleij@linaro.org>
References: <1379708226-7802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdYo-mci-2hSw7WZRJREV4RLPkV_d+x6USgViz0ta2dAog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 10:17 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This is a resend of the IOP GPIO refactoring, this time
> I took some extra care to be sure I moved all the IOP32x boards
> to instantiate their platform devices properly, as noted
> by Aaro.
>
> Also available as a branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup
>
> Testing and ACKing appreciated.

ARM SoC folks: are you happy with me taking this into the
GPIO tree?

Yours,
Linus Walleij
