From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 26 Aug 2010 11:45:58 +0200 (CEST)
Subject: [RFC][PATCH] add
	dma_reserve_coherent_memory()/dma_free_reserved_memory() API
In-Reply-To: <20100826182915S.fujita.tomonori@lab.ntt.co.jp>
References: <201008260904.19973.mitov@issp.bas.bg>
	<20100826152333K.fujita.tomonori@lab.ntt.co.jp>
	<Pine.LNX.4.64.1008261100150.14167@axis700.grange>
	<20100826182915S.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <Pine.LNX.4.64.1008261140390.14167@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010, FUJITA Tomonori wrote:

> Why can't you revert a commit that causes the regression?

See this reply, and the complete thread too.

http://marc.info/?l=linux-sh&m=128130485208262&w=2

> The related DMA API wasn't changed in 2.6.36-rc1. The DMA API is not
> responsible for the regression. And the patchset even exnteds the
> definition of the DMA API (dma_declare_coherent_memory). Such change
> shouldn't applied after rc1. I think that DMA-API.txt says that
> dma_declare_coherent_memory() handles coherent memory for a particular
> device. It's not for the API that reserves coherent memory that can be
> used for any device for a single device.

Anyway, we need a way to fix the regression.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
