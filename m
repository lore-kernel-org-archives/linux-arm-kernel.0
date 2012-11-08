From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Nov 2012 08:28:33 -0800
Subject: [PATCH 0/7] ARM: remove init_consistent_dma_size() stub
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20121108162833.GC6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [121107 23:48]:
> Hello,
> 
> Commit e9da6e9905e639b0 ("ARM: dma-mapping: remove custom consistent dma
> region") replaced custom consistent memory handling, so setting
> consistent dma memory size is not longer required. This patch series
> cleans sub-architecture platform code to remove all calls to the
> obsolated init_consistent_dma_size() function and finally removes the
> init_consistent_dma_size() stub itself.
> 
> Arnd, Olof: could You apply it to arm-soc cleanup branch?

The omap patch in this series is no longer needed as soon as
Arnd and Olof pull in the pending omap pull requests I sent.

Regards,

Tony
