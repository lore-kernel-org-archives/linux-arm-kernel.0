From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 14 Jun 2011 00:58:22 +0900
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <201106131746.18972.arnd@arndb.de>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<201106131746.18972.arnd@arndb.de>
Message-ID: <BANLkTinFNz5b-Duz_-pYyAShzFSUrORE_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm totally not following this argument. This has nothing to do with IOMMU
> or not. If you have an IOMMU, the dma code will know where the pages are
> anyway, so it can always map them into user space. The dma code might
> have an easier way to do it other than follwoing the page tables.
>
Ah. Sorry for that. I mixed dma_alloc_* up with dma_map_*.
I identified the reason why mmap_* in dma_map_ops is required.
You mean that nothing but DMA API knows what pages will be mapped to user space.
Thanks anyway.

KyongHo.
