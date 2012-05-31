From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:56:27 +0800
Subject: [RFC 11/34] dmaengine: PL08x: get src/dst addr direct from
 dma_slave_config struct
In-Reply-To: <E1SZItH-0006zR-2R@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZItH-0006zR-2R@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdajmYUGb0PhVJraTREmMZ4PuA+RUwqmhXY8ZTrt7GAXEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:38 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add a dma_slave_config struct to struct pl08x_dma_chan, and move the
> src_addr/dst_addr arguments into this struct. ?This is a step away
> from using the dma_slave_config's direction member.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
