From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Feb 2014 15:32:10 +0100
Subject: [PATCH 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <1391529538-21685-12-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-12-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdawmeE3+UAddXhn0OcwgKQhBYXyGYmZa115b7poiEtRZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Use devm_* functions to simplify code and error handling.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

However make sure this (and the rest) applies on top of this patch:
http://marc.info/?l=linux-i2c&m=139142325809973&w=2

Because I expect that to be applied first.

Yours,
Linus Walleij
