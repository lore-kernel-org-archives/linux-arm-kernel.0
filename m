From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:43:35 +0200
Subject: [PATCH 14/14] ARM: ux500: Move rtc-pl031 registration to Device
 Tree when enabled
In-Reply-To: <1339428307-3850-15-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbJdA8rgcXX4Xc3sMrx==5jd-Scu1Xy0UKz0ot3_bbNzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> During a Device Tree boot, all probing will now be completed on parse
> of the Device Tree binary. In the same patch we remove platform
> registration of the Real Time Clock.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Oh this is a bug fix really, well it's in the device tree so nevermind.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
