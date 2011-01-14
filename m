From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 14 Jan 2011 16:08:31 +0100
Subject: [PATCH] Fix dmaengine_submit() return type
In-Reply-To: <20110101230023.GE25924@n2100.arm.linux.org.uk>
References: <20110101230023.GE25924@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikW3ha0WdqHWTfdhg0o-Nh2nmd=8=owfSgB-MJu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> desc->tx_submit's return type is dma_cookie_t, not int. ?Therefore,
> dmaengine_submit() should match this return type as it's just
> wrapping this detail.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
FWIW

Yours,
Linus Walleij
