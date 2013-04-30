From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Apr 2013 22:43:01 +0200
Subject: [PATCH 3/5] ARM: ux500: Stop passing DMA platform data though
 AUXDATA
In-Reply-To: <1367336497-10650-3-git-send-email-lee.jones@linaro.org>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
 <1367336497-10650-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201304302243.02145.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013, Lee Jones wrote:
> The DMA platform data is now empty due to some recent refactoring,
> so there is no longer a requirement to pass it though.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
