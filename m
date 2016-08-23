From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Aug 2016 12:29:43 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: fix uart1 CTS/RTS pins at PG on
 A23/A33
In-Reply-To: <20160823055826.20591-1-icenowy@aosc.xyz>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
Message-ID: <CACRpkdarLKZD21YF-q5PAerjbbJoKi790SAThPiYGDbGjhGC7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 7:58 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> PG8, PG9 is said to be the CTS/RTS pins for UART1 according to the A23/33
> datasheets. However, the function is wrongly named "uart2" in the pinctrl
> driver. This patch fixes this by modifying them to be named "uart1".
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Applied for stable with Maxime's ACK.

Yours,
Linus Walleij
