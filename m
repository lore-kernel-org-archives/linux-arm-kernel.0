From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 08:57:42 +0100
Subject: [PATCH] gpiolib: fix bug and clarify OF use of ranges
In-Reply-To: <CAKohpokYD7Cyv77p4MtmtJ+UJSfb3fjYWmjXkQV40Czbh7FOWw@mail.gmail.com>
References: <1353483465-25961-1-git-send-email-linus.walleij@stericsson.com>
 <CAKohpokYD7Cyv77p4MtmtJ+UJSfb3fjYWmjXkQV40Czbh7FOWw@mail.gmail.com>
Message-ID: <CACRpkdbykZxp=vUzLzy6to3VhmnLjSXAKWOWj4f4S2u5xzipYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 8:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> This is what i was asking you earlier: "Doesn't gpiochip_add_pin_range
> have any users?" and you said NO and i didn't cross checked :(

Yes I forgot that I refactored the OF code to actually use this
function.... sorry.

Thanks,
Linus Walleij
