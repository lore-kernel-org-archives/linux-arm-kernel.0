From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Apr 2018 11:17:19 +0200
Subject: [PATCH] net: gemini: fix gmac_start_xmit()'s return type
In-Reply-To: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
References: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
Message-ID: <CACRpkdaR=wqCfRmyqpLufYoLbFHr9ixy6gZq6MqdaGdaXPiQzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 3:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this!
Linus Walleij
