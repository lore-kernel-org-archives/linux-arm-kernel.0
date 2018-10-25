From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2018 13:18:09 +0200
Subject: [PATCH] mmc: sdhci: Conver sdhci_allocate_bounce_buffer() to
 return void
In-Reply-To: <1540365564-30645-1-git-send-email-zhang.chunyan@linaro.org>
References: <1540365564-30645-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <CACRpkdb3uwW+UoeeivAP-+67kMKGD9dP0rh2nk=WTHhpgnkJ1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 9:19 AM Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> The function sdhci_allocate_bounce_buffer() always return zero at
> present, so there's no need to have a return value, that will also make
> error path easier.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
