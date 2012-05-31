From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:02:07 +0800
Subject: [RFC 16/34] dmaengine: PL08x: get rid of unnecessary checks in
 dma_slave_config
In-Reply-To: <E1SZIut-0006zm-Jl@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIut-0006zm-Jl@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZc0rAFxQJCGNT9EjBH9CWymfCnBJwYn_ZDMHU7TFb4HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:40 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Get rid of the unnecessary checks in dma_slave_config utilizing
> the DMA direction. ?This allows us to move the computation of
> cctl to the prepare function.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
