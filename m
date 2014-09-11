From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 10:56:42 +0200
Subject: [PATCH v2] Enable gcov support on the ARM architecture
In-Reply-To: <1410421758-13173-1-git-send-email-riku.voipio@linaro.org>
References: <1410421758-13173-1-git-send-email-riku.voipio@linaro.org>
Message-ID: <4844458.pSrskHNd5e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 10:49:18 Riku Voipio wrote:
> Enable gcov support for ARM based on original patches by David
> Singleton and George G. Davis
> 
> Riku - updated to patch to current mainline kernel. The patch
> has been submitted in 2010, 2012 - for symmetry, now in 2014 too.
> 
> https://lwn.net/Articles/390419/
> http://marc.info/?l=linux-arm-kernel&m=133823081813044
> 
> v2: remove arch/arm/kernel from gcov disabled files
> 
> From: Vincent Sanders <vincent.sanders@collabora.co.uk>
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> Signed-off-by: Vincent Sanders <vincent.sanders@collabora.co.uk>

This version looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
