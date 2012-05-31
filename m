From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:21:39 +0800
Subject: [RFC 25/34] dmaengine: PL08x: start next descriptor from irq
 context
In-Reply-To: <E1SZIxo-00070N-Kj@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIxo-00070N-Kj@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdb7CW_-AH8entK-57-3vKrj-G4EbVX-JPK8n8G1HKoA1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:43 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Rather than waiting for the tasklet to run, we can start the next
> descriptor from interrupt context, as soon as we know that the
> previous descriptor has completed.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Quicker and more elegant,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
