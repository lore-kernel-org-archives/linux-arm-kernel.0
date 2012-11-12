From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 21:21:15 +0000
Subject: [PATCH 0/7] ARM: remove init_consistent_dma_size() stub
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201211122121.16219.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Marek Szyprowski wrote:
> Commit e9da6e9905e639b0 ("ARM: dma-mapping: remove custom consistent dma
> region") replaced custom consistent memory handling, so setting
> consistent dma memory size is not longer required. This patch series
> cleans sub-architecture platform code to remove all calls to the
> obsolated init_consistent_dma_size() function and finally removes the
> init_consistent_dma_size() stub itself.
> 
> Arnd, Olof: could You apply it to arm-soc cleanup branch?
> 

Applied patches 2-7 to next/cleanup branch, with the Acks that came in.

Thanks,

	Arnd
