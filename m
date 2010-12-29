From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 29 Dec 2010 01:53:00 +0100
Subject: [PATCH 0/6] PL011 DMA support
In-Reply-To: <20101224102359.GC20587@n2100.arm.linux.org.uk>
References: <20101224102359.GC20587@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=bTjw2rKe0A4J6eMp1rgDBdcAvXGCYux6GYT6L@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Re-post of the previous set, but using writew() instead of writew_relaxed().
> writew_relaxed() is not part of the MMIO accessor API, and so should
> not be used in drivers which may be used on other architectures.

Comments on RX but nothing that big that it cannot be discussed
separately at a later point.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
