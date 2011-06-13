From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 14 Jun 2011 01:00:16 +0900
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <20110613154033.GA29185@1n450.cable.virginmedia.net>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<20110613154033.GA29185@1n450.cable.virginmedia.net>
Message-ID: <BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> FWIW, on ARMv6 and later hardware, the dma_alloc_coherent() provides
> writecombine memory (i.e. Normal Noncacheable), so no need for
> dma_alloc_writecombine(). On earlier architectures it is creating
> Strongly Ordered mappings (no writecombine).
>
Thanks.

Do you mean that dma_alloc_coherent() and dma_alloc_writecombine() are
not different
except some additional features of dma_alloc_coherent() in ARM?
