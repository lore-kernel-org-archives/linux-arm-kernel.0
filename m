From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:57:53 +0800
Subject: [RFC 13/34] dmaengine: PL08x: move the bus and increment
 selection to dma prepare function
In-Reply-To: <E1SZItv-0006zZ-9O@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZItv-0006zZ-9O@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdY5joL7zJ_vZiG0rg8apWCexRLF8+5bj8E_wiUHJsKLqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:39 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Move the bus and transfer increment selection to the DMA prepare
> function rather than the slave configuration function.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
