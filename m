From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 12:44:23 +0200
Subject: [PATCH 0/9] Fix ux500 crypto drivers and init DMA in the correct
 way
In-Reply-To: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181244.24036.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> These drivers haven't been touched in a while. They didn't even compile
> or probe successfully. After these changes, both drivers run just fine.
> 
> We also split DMA channel allocation and configuration into separate
> invocations, as the API expects.

Very nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>
