From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:24:21 +0800
Subject: [RFC 29/34] dmaengine: PL08x: convert to use vchan
 submitted/issued lists
In-Reply-To: <E1SZIz7-00070e-3J@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIz7-00070e-3J@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYZt2vpb2+kteWk-97Q_B_yyxZL+NfKH5OwRtBHZCz1Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:45 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Convert to use the virtual dma channel submitted/issued descriptor
> lists rather than our own private lists, and use the virtual dma
> channel support functions to manage these lists.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
