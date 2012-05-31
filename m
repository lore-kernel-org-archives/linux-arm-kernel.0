From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:57:15 +0800
Subject: [RFC 12/34] dmaengine: PL08x: get rid of device_fc in struct
 pl08x_dma_chan
In-Reply-To: <E1SZItb-0006zV-69@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZItb-0006zV-69@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaai-+weddOVcXqTG2seguH4qjk2xpD860gfQxxJEPDwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:39 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> As we now store the dma_slave_config in pl08x_dma_chan, we don't need
> to store this separately. ?Use the one in dma_slave_config directly.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
