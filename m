From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 12:23:32 +0100
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 7, 2013 at 5:47 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> This patch converts the module to use clk_prepare_enable and
> clk_disable_unprepare variants as required by common clock framework.
>
> Without this the system crash during probe function.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
