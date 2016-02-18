From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:19:46 +0100
Subject: [PATCH v2 2/5] gpio: remove broken irq_to_gpio() interface
In-Reply-To: <1455637261-2920972-2-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-2-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdaNA0p95f8i4o0+Abqc-YshvaBhOBAWbi=s1AfFmeHY_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> gpiolib has removed the irq_to_gpio() API several years ago,
> but the global header still provided a non-working stub.
>
> To prevent new users of this broken function from showing
> up, let's remove the stubs as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
