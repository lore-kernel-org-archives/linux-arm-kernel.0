From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 21:22:40 +0200
Subject: [PATCH] pinctrl: at91: fix get_pullup/down function return
In-Reply-To: <1377609561-22054-1-git-send-email-b.brezillon@overkiz.com>
References: <1377609561-22054-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkdYJHctvmK0Lj+dStacCrBZbsVKJFBCc6ZTKWP5SMVVZAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 3:19 PM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> In PIO_PUSR and PIO_PPDSR register if a given bit is set 1 this means the
> pullup/down for this pin (pin is represented as a bit position) is
> disabled.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Patch applied, tagged for stable.

Yours,
Linus Walleij
