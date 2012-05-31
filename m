From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:03:13 +0800
Subject: [RFC 17/34] dmaengine: PL08x: split DMA signal muxing from
 channel alloc
In-Reply-To: <E1SZIvD-0006zq-NT@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIvD-0006zq-NT@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaxGU-va2yiqB8PEv1=Mr8EnRF+QV2+Z7n4tTaKdXdu3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:40 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Split the DMA request mux signal handling from the physical channel
> allocation code. ?The physical channel has very little to do with the
> DMA request input which will be used, so these should be two separate
> operations.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
