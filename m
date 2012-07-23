From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 23 Jul 2012 16:36:17 +0200
Subject: [GIT PULL] Samsung devel-dma ops for v3.6
In-Reply-To: <0e1301cd5f34$008fe1e0$01afa5a0$%kim@samsung.com>
References: <0c5001cd5e41$87daa1b0$978fe510$%kim@samsung.com>
 <201207101242.41867.arnd@arndb.de>
 <0e1301cd5f34$008fe1e0$01afa5a0$%kim@samsung.com>
Message-ID: <CAKnu2Mqf+_JwaZbpfPCJ1go1iTkPb3VLRwj=pFjcr1Apu0O8fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/11 Kukjin Kim <kgene.kim@samsung.com>:

> Yeah, let me explain the status for Samsung SoCs' DMA. There are 3 different
> DMA IPs, samsung specific s3c24xx dma, pl080 and pl330. As you know, pl330
> already moved in drivers/dma for using common DMA engine and Alim is
> re-working on pl080
> (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg10954.html
> ) and let me check its progress. But s3c24xx dma is not ready yet.

I'm going to poke again on this. I think a bunch of changes to the PL080
driver from Russell is going upstream this merge window and the S3C patch
series need to be rebased onto that, but it should be pretty straight-forward.

Can we please have something moving the S3C over to dmaengine *early*
next kernel cycle?

Yours,
Linus Walleij
