From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 15:44:53 +0100
Subject: [PATCH v3 6/7] pinctrl: at91: implement get_direction
In-Reply-To: <1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-7-git-send-email-richard.genoud@gmail.com>
Message-ID: <CACRpkdZN_fT05+1JCJ2bemN3KfpfFFWu__HQcL9Sz7n2M9gCnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 5:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:

> This is needed for gpiod_get_direction().
> Otherwise, it returns -EINVAL.
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can I apply this directly to the pinctrl tree or do you want it to
go through AT91 ARM SoC with the rest of these patches
or something?

Yours,
Linus Walleij
