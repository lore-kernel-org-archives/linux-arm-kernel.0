From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 08:56:47 +0100
Subject: [PATCH] gpiolib: fix bug and clarify OF use of ranges
In-Reply-To: <1353483465-25961-1-git-send-email-linus.walleij@stericsson.com>
References: <1353483465-25961-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdZSfyffBCZ7jorxV28qpeSt37HV2cPaBcyqA1QPNwjmcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 8:37 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> In commit c905165f5946f56dca195871641bd4e488eca24a
> "gpiolib: let gpiochip_add_pin_range() specify offset"
> I forgot to update the OF use of the function
> gpiochip_add_pin_range().
>
> It turns out that this reveal a weakness in the
> OF range mappings: ranges cannot currently be sparse.
> So put in a comment so we can fix this later.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

BTW I've squashed this into the original commit above to avoid any
git bisect issues.

Linus Walleij
