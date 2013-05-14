From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 11:01:34 +0200
Subject: [PATCH] mmc: sdhci-sirf: let device core setup the default pin
 configuration
In-Reply-To: <1368510549-7230-1-git-send-email-Baohua.Song@csr.com>
References: <1368510549-7230-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdY_Y1JWxS5QfPKwpt6nMvWzuYK4g=MX=ztsxNTE8dqyaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 7:49 AM, Barry Song <Baohua.Song@csr.com> wrote:

> With device core now able to setup the default pin configuration, the call
> to devm_pinctrl_get_select_default can be removed. And the pin configuration
> code based on the deprecated Samsung specific gpio bindings is also removed.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Also delete this line:
#include <linux/pinctrl/consumer.h>

After that: Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
