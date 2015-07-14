From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 10:55:39 +0200
Subject: [PATCH v2 5/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
In-Reply-To: <1435667250-28299-6-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-6-git-send-email-pawelo@king.net.pl>
Message-ID: <CACRpkdZE9foKeNMkn+O9ZF9xLkkdDnkJXKN8jxY8U5ZU81vbaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 2:27 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:

> This is a very cheap and simple implementation of pinctrl driver
> for Kinetis SoC - its primary role is to provide means for enabling UART
> fuctionality on I/O PORT_E which will be utilized by the commits
> yet to come.
>
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>

Same comments as for v1. Sorry for taking time to review,
was in the merge window and some vacation.

Yours,
Linus Walleij
