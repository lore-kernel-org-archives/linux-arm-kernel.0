From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 28 Mar 2012 15:29:07 +0400
Subject: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
In-Reply-To: <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F72F603.2000803@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-03-2012 17:42, Marek Szyprowski wrote:

> Introduce new generic alloc and free methods with attributes argument.

    The method names don't match the ones in the subject.

> Existing alloc_coherent and free_coherent can be implemented on top of the
> new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.

> This way the drivers will get more generic, platform independent way of
> allocating dma buffers with specific parameters.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

WBR, Sergei
