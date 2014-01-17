From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 15:42:21 +0100
Subject: [PATCH v16] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1389948365-13999-1-git-send-email-jonas.jensen@gmail.com>
References: <1387189499-26300-1-git-send-email-jonas.jensen@gmail.com>
 <1389948365-13999-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201401171542.21970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Jonas Jensen wrote:
> The MOXA ART SoC has a DMA controller capable of offloading expensive
> memory operations, such as large copies. This patch adds support for
> the controller including four channels. Two of these are used to
> handle MMC copy on the UC-7112-LX hardware. The remaining two can be
> used in a future audio driver or client application.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
