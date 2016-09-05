From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Sep 2016 11:09:38 +0200
Subject: [PATCH 0/6] SA11x0 serial updates
In-Reply-To: <20160829120531.GG1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
 <20160829120531.GG1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 2:05 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> This series converts SA11x0 serial to make use of the mctrl helpers
> where appropriate.  This allows us to remove several board-specific
> callbacks.

>From GPIO and H3600 point of view:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
