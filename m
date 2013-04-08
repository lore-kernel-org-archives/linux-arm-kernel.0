From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 18:13:33 +0200
Subject: [PATCH 2/5] dmaengine: ste_dma40: Assign memcpy channels in the
 driver
In-Reply-To: <1365434591-21569-2-git-send-email-lee.jones@linaro.org>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <1365434591-21569-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201304081813.33926.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Lee Jones wrote:
> The channels reserved for memcpy are the same for all currently
> supported platforms. With this in mind, we can ease the platform
> data passing requirement by moving these assignments out from
> platform code and place them directly into the driver.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
