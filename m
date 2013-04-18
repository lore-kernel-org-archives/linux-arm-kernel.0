From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 23:53:44 +0200
Subject: [PATCH 24/32 v3] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <20130418141752.GC3959@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <20130418121253.GF27903@gmail.com> <20130418141752.GC3959@gmail.com>
Message-ID: <201304182353.45092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> Using the new DMA DT bindings and API, we can register the DMA40 driver
> as Device Tree capable. Now, when a client attempts to allocate a
> channel using the DMA DT bindings via its own node, we are able to parse
> the request and allocate a channel in the correct manner.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
