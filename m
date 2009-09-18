From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 18 Sep 2009 10:55:44 +0200
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
Message-ID: <63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/17 H Hartley Sweeten <hartleys@visionengravers.com>:

> This reorganizes the vic.c code in anticipation of a future patch
> to use struct vic_device as the data stored in set_irq_chip_data().

This doesn't apply cleanly to -next anymore, can you send an
updated version and I'll test it?

Linus Walleij
