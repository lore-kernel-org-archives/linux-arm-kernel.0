From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Apr 2012 11:05:49 +0200
Subject: [PATCH 2/7] ARM: ux500: New DT:ed u8500_init_devices for
 one-by-one device enablement
In-Reply-To: <1333619748-16126-3-git-send-email-lee.jones@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb9VAR2y=7hw43YDAzpQa3eetgHVayjfzs=m63rLvBsEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 11:55 AM, Lee Jones <lee.jones@linaro.org> wrote:

> +// TODO: Once all pieces are DT:ed, remove completely

/* Comment style, no C99 comments in the kernel */

> +// TODO: Once all pieces are DT:ed, remove completely

Dito.

> +extern struct device * __init u8500_of_init_devices(void);
> +

No cheating with external, add it to the header file instead.

Yours,
Linus Walleij
