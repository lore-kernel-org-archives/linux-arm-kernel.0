From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 17:47:30 +0200
Subject: [PATCH] ARM: shmobile: kzm9g: use gpio-keys instead of
 gpio-keys-polled
In-Reply-To: <1347341165-15573-2-git-send-email-horms@verge.net.au>
References: <1347341165-15573-1-git-send-email-horms@verge.net.au>
 <1347341165-15573-2-git-send-email-horms@verge.net.au>
Message-ID: <CACRpkdbP-gw3_RAmBUc=eJaTKwn1Q0eyk-xrpynZrDApYi8Vgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 7:26 AM, Simon Horman <horms@verge.net.au> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> 6e20a0a429bd4dc07d6de16d9c247270e04e4aa0
> (gpio: pcf857x: enable gpio_to_irq() support) supports
> gpio_to_irq() on pcf857x driver.
> Now, we can use gpio-keys driver instead of gpio-keys-polled.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Applied, thanks!
Linus Walleij
