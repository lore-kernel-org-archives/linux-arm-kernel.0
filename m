From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Jun 2012 20:06:06 +0200
Subject: [PATCH v3 2/2] mmc: mmci.c: Remove wrong error handling of gpio 0
In-Reply-To: <1339927893-8842-3-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
 <1339927893-8842-3-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdZMpmjbg-onF9bohBjrt0AadcauzJ-w2VpgbqJ8Kz9YDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 12:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> Zero is a valid GPIO and shouldn't be handled as an error return code from
> of_get_named_gpio(). It was a leftover from old code before getting
> pdata->gpio_*() was modified.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls put this into Russell's patch tracker with the other patch.

Yours,
Linus Walleij
