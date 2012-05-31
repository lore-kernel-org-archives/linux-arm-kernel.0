From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:03:43 +0800
Subject: [RFC 18/34] dmaengine: PL08x: move DMA signal muxing into
 pl08x_dma_chan struct
In-Reply-To: <E1SZIvX-0006zu-R9@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIvX-0006zu-R9@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkda_7UiC7Vgf+MLt_TJFRd4WXs+1aWYEuJ94_7nJ5TZA=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:41 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Move the signal handling out of the physical channel structure into
> the virtual channel structure, where it should belong as it has more
> to do with the virtual channel than the physical one.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
