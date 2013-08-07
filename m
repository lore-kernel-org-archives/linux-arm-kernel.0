From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:42:42 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add spinlocks
In-Reply-To: <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYS-7MPTTSg4psJ3NZ_jhA15aMeFLoxFNAN7hSqe4hRTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 12:38 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current code use no locking at all, which is obviously not that
> great and can lead to concurrency issues, especially with the newer SMP
> SoCs from Allwinner.
>
> Add some locking where it's needed.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This does not apply to my fixes branch which is based off
v3.11-rc4.

It is also too big to go into fixes.

I think it may be requiring the other queued Allwinner things,
so it is better if I apply this on the devel branch after looking over
that Allwinner A20/A31 stuff?

Yours,
Linus Walleij
