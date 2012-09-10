From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 06:10:59 -0700
Subject: [PATCH 18/19] gpio: Provide the tc3589x GPIO expander driver with
 an IRQ domain
In-Reply-To: <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYbWEq5mhTcewmxEpcivXkVyQS_56QRU67G40zcRXnUCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In preparation for Device Tree enablement all IRQ controllers
> should control their own IRQ domain. This patch provides just
> that for the tc3589x GPIO expander.
>
> CC: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks very good again,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I presume you will want to push the whole shebang through
ARM SoC, but if that doesn't work out I am very tempted to
apply this patch to the GPIO tree immediately so it lands
in v3.7.

Yours,
Linus Walleij
