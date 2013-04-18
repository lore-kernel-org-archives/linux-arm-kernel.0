From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 13:08:02 +0200
Subject: [PATCH 25/32] ARM: ux500: Setup the DMA40 driver's DT node using
 the new DMA API
In-Reply-To: <1366279934-30761-26-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-26-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181308.03130.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> The new DMA is now available, so let's use it to setup ST-Ericsson's
> DMA40 driver when Device Tree is enabled.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
