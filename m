From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Mar 2014 09:52:29 +0800
Subject: [PATCH 2/5] gpio: remove obsolete tnetv107x driver
In-Reply-To: <1393418614-3968549-3-git-send-email-arnd@arndb.de>
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
 <1393418614-3968549-3-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdaBMozNayXXyn8Ag+GUU_+C2j4X7aVuaZjgV_krCvSy0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 8:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The tnetv107x platform is getting removed, so this driver won't
> be needed any more.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio at vger.kernel.org

Can I have an ACK from some Sekhar to apply this
to the GPIO tree, so we are all aligned?

Or do you want my ACK to take this through ARM SoC?
In that case Acked-by...

Yours,
Linus Walleij
