From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 12:53:33 +0200
Subject: [PATCH 14/32] dmaengine: ste_dma40: Remove 'always true' checking
In-Reply-To: <1366279934-30761-15-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-15-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181253.33762.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> Before allocating memory for logical channels, the current driver
> checks to see if there are any. Well as the dma40_memcpy_channels[]
> array is always populated, the check is always true. Best to
> remove the check.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
