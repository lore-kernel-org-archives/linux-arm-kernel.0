From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 00:33:56 +0200
Subject: [PATCH] pinctrl: sunxi: Fix recursive dependency
In-Reply-To: <4667053.sVVFqnz4qh@wuerfel>
References: <1400343715-27884-1-git-send-email-maxime.ripard@free-electrons.com>
 <4667053.sVVFqnz4qh@wuerfel>
Message-ID: <CACRpkdZ2Bo3UEZtC7cHYx0dCGOGqcA6FQrGkqp-XysMv2TA8oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 1:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I stubled over the same thing already, but came to a different conclusion.
(...)
> This means you won't be able to stop selecting all drivers dropping
> the 'select PINCTRL_SUNXI' later. How about this one?
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I conjured a commit message and applied Arnd's patch.

Yours,
Linus Walleij
