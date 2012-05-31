From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:01:08 +0800
Subject: [RFC 15/34] dmaengine: PL08x: ignore 'direction' argument in
 dma_slave_config
In-Reply-To: <E1SZIuZ-0006zi-Gf@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIuZ-0006zi-Gf@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYeYgjbrCTsf=PaRCujtOsx5939sZeXxv8KwiJ4mY_m7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:40 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Ignore the direction argument in dma_slave_config, and configure both
> directions independently. ?We still check that the configuration for
> the intended direction is valid; this check will eventually be dropped.
> This check is just for debugging at present.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
