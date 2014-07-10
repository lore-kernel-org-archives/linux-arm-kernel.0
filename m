From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 16:35:01 +0200
Subject: [PATCH 08/16] i2c: i2c-nomadik: Drop class based scanning to
 improve bootup time
In-Reply-To: <1404992799-3705-9-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <1404992799-3705-9-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdZ9WpHVcv8vX8rVzxRaB=-BgHApUrHYZqwkr=m6d2pjGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 1:46 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> This driver has been flagged to drop class based instantiation. The removal
> improves boot-up time and is unneeded for embedded controllers. Users have been
> warned to switch for some time now, so we can actually do the removal. Keep the
> DEPRECATED flag, so the core can inform users that the behaviour finally
> changed now. After another transition period, this flag can go, too.
> While we are here, remove the indentation for the array setup because
> such things always break after some time.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
