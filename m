From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:15:28 +0200
Subject: [PATCH] pinctrl: uniphier: add UART hardware flow control pin-mux
 settings
In-Reply-To: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CACRpkdatq6B7Of1DZAq0RcwcHxf6Qy1HcMaCC=3Wb_ogYsYfvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 9:13 AM, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> UniPhier SoCs have the following pins for hardware flow control of UART:
>   XRTS, XCTS
> and for modem control of UART:
>   XDTR, XDSR, XDCD, XRI
>
> The port number with the flow control is SoC-dependent.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Masahiro's ACK!

Yours,
Linus Walleij
