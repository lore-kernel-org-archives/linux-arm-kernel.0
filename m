From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Aug 2013 20:42:13 +0200
Subject: [PATCH v8] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1375792711-21853-1-git-send-email-jonas.jensen@gmail.com>
References: <1375713457-5562-1-git-send-email-jonas.jensen@gmail.com>
 <1375792711-21853-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201308062042.13809.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 August 2013, Jonas Jensen wrote:
> The MOXA ART SoC has a DMA controller capable of offloading expensive
> memory operations, such as large copies. This patch adds support for
> the controller including four channels. Two of these are used to
> handle MMC copy on the UC-7112-LX hardware. The remaining two can be
> used in a future audio driver or client application.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Looks all good to me now,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
