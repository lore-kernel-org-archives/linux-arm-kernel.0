From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Dec 2013 15:33:10 +0100
Subject: [PATCH] serial: pl011: also enable DMA Rx polling with no
 platform data
In-Reply-To: <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
 <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
Message-ID: <CACRpkdZne6VQUgKWL7JvN+7PdwoV6K2Vebv=EWSJ6LMAym-ejg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 12:53 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> An earlier patch "serial: pl011: use DMA RX polling by default" enabled
> DMA Rx polling on PL011 only in configurations, using platform data. A
> simple extension of that patch also enables DMA Rx polling when no
> platform data is used, e.g. in Device Tree configurations. In such cases
> a default poll timeout and an automatically calculated poll rate will be
> used.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Makes perfect sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
