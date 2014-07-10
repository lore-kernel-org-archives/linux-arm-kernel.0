From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 16:35:33 +0200
Subject: [PATCH 14/16] i2c: i2c-stu300: Drop class based scanning to
 improve bootup time
In-Reply-To: <1404992799-3705-15-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <1404992799-3705-15-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkdZ-ZhQQz2-gvSDH-XYCcL-cL5fZKCEw9jeEpDUVRpazng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 1:46 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> This driver has been flagged to drop class based instantiation. The removal
> improves boot-up time and is unneeded for embedded controllers. Users have been
> warned to switch for some time now, so we can actually do the removal. Keep the
> DEPRECATED flag, so the core can inform users that the behaviour finally
> changed now. After another transition period, this flag can go, too.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
