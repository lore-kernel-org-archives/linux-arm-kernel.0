From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 8 Sep 2011 13:27:22 -0400
Subject: [PATCH 7/8] ARM: integrate CMA with DMA-mapping subsystem
In-Reply-To: <1313764064-9747-8-git-send-email-m.szyprowski@samsung.com>
References: <1313764064-9747-1-git-send-email-m.szyprowski@samsung.com>
	<1313764064-9747-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAMjpGUch=ogFQwBLqOukKVnyh60600jw5tMq-KYeNGSZ2PLQpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 10:27, Marek Szyprowski wrote:
> ?arch/arm/include/asm/device.h ? ? ? ? | ? ?3 +
> ?arch/arm/include/asm/dma-contiguous.h | ? 33 +++

seems like these would be good asm-generic/ additions rather than arm
-mike
