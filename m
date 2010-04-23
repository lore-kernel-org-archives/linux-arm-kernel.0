From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 23 Apr 2010 23:49:34 +0200
Subject: [PATCH 1/7] PL330: Add common core driver
In-Reply-To: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/4/21  <jassisinghbrar@gmail.com>:

> PL330 is a configurable DMA controller PrimeCell device.
> The register map of the device is well defined.
> The configuration of a particular implementation can be
> read from the six configuration registers CR0-4,Dn.

I think this looks better for every iteration and is definately ripe
for merge, so FWIW:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

> The exported interface should be sufficient to implement
> a driver for any DMA API.

Will you make an attempt at doing this in time for the next
merge window as well? That would be perfect.

Yours,
Linus Walleij
