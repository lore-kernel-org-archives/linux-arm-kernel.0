From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 4 May 2015 11:36:00 +0200
Subject: [PATCH 2/4] tty: serial: 8250_mtk: Use devm_clk_get
In-Reply-To: <1430117397-13517-3-git-send-email-s.hauer@pengutronix.de>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
 <1430117397-13517-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBe+qXf6xHkvTbBQ-FDVQAoQL-S-OiAS6dCry6e+aCyVvqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-27 8:49 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> When a struct device * is present clk_get should be used rather
> than of_clk_get. Use the devm variant of this function to be able to
> drop the clk_put in the error and remove pathes. While at it fix
> a wrong error message.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
