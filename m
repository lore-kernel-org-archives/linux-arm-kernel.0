From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:39:54 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: Read register before writing to it in
 irq_set_type
In-Reply-To: <1375612728-20501-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375612728-20501-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdavg=VxXXZ9i2qOGM1geQ82tCbuM0i9sPx=KDJFPgUwSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 12:38 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current irq_set_type code doesn't read the current register value
> before writing to it, leading to the older programmed values being
> overwritten and everything but the latest value being reset.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied for fixes.

Yours,
Linus Walleij
