From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 May 2013 12:27:06 +0200
Subject: [PATCH 5/5 v2] dmaengine: ste_dma40: Fetch disabled channels from
 DT
In-Reply-To: <20130501095406.GE25256@gmail.com>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
 <1367336497-10650-5-git-send-email-lee.jones@linaro.org>
 <20130501095406.GE25256@gmail.com>
Message-ID: <201305011227.07086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 May 2013, Lee Jones wrote:
>     Some platforms have channels which are not available for normal use.
>     This information is currently passed though platform data in internal
>     BSP kernels. Once those platforms land, they'll need to configure them
>     appropriately, so we may as well add the infrastructure.
>     
>     Cc: Vinod Koul <vinod.koul@intel.com>
>     Cc: Dan Williams <djbw@fb.com>
>     Cc: Per Forlin <per.forlin@stericsson.com>
>     Cc: Rabin Vincent <rabin@rab.in>
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
