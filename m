From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 18:14:00 +0200
Subject: [PATCH 3/5] dmaengine: ste_dma40: Move default memcpy configs
 into the driver
In-Reply-To: <1365434591-21569-3-git-send-email-lee.jones@linaro.org>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <1365434591-21569-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201304081814.00868.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Lee Jones wrote:
> There are only two default memcpy configurations used for the DMA40
> driver; one for physical memcpy and one for logical memcpy. Instead
> of invariably passing the same configurations though platform data,
> we're moving them into the driver instead.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
