From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:52:08 +0100
Subject: [PATCH] pinctrl: sirf: Staticize non-exported symbol
In-Reply-To: <1352123068.14769.6.camel@phoenix>
References: <1352123068.14769.6.camel@phoenix>
Message-ID: <CACRpkdbM20TVDC0HGyDpafhWtLmyE-VLqzJjX9Z2btcnVhriRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 2:44 PM, Axel Lin <axel.lin@ingics.com> wrote:

> Staticize sirfsoc_gpio_irq_map() function.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied with Barry's ACK, thanks!
Linus Walleij
