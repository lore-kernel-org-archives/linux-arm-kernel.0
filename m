From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 09:01:49 +0200
Subject: [PATCH RESEND] gpio-lpc32xx: Fix value handling of
 gpio_direction_output()
In-Reply-To: <1348559634-15337-1-git-send-email-stigge@antcom.de>
References: <1348559634-15337-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdauqV8LwA=jRFUE1Dd7rJ_kLGMDr44Uv_6XMFBhe1b9-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 9:53 AM, Roland Stigge <stigge@antcom.de> wrote:
> For GPIOs of gpio-lpc32xx, gpio_direction_output() ignores the value argument
> (initial value of output). This patch fixes this by setting the level
> accordingly.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
>
> ---
> Applies to v3.6-rc7

I will attempt to funnel this to Torvalds today.

Thanks,
Linus Walleij
