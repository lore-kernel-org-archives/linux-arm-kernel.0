From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Apr 2012 14:21:02 +0000
Subject: [PATCH 0/7 v2] Next round of DT enablement for ux500/Snowball
In-Reply-To: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201204131421.02875.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 April 2012, Lee Jones wrote:
> 
> In this patch-set we change a couple of DT compatible entries
> to something less cumbersome. Then we have a second stab at 
> enabling DT for mmci. Only this time keeping it simple and 
> continuing to use current DMA initialisation code. We'll 
> change that once the generic bindings for DMA have been 
> mainlined. Finally we enable Snowball's GPIO controller.

Looks good.

Acked-by: Arnd Bergmann <arnd@arndb.de>

for the entire series.

	Arnd
