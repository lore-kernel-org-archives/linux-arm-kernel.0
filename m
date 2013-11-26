From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Nov 2013 00:23:32 +0100
Subject: [PATCH] Versatile LEDs initialise to off state
In-Reply-To: <20131126194418.GI16735@n2100.arm.linux.org.uk>
References: <20131126194418.GI16735@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaj_CVj8E6UQWgA7-en8xuhfaVtoBy9nXOHfJ_Fu=2qOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 8:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> There really is no excuse to turn on all 8 LEDs at boot time, such
> that on the Versatile PB/926 we end up with 6 LEDs on continuously
> and forever.  We're not a christmas decoration!
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you want me to queue this patch thru ARM SoC or are you
taking it through your tree?

Yours,
Linus Walleij
