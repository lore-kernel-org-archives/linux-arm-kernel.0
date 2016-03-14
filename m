From: davem@davemloft.net (David Miller)
Date: Mon, 14 Mar 2016 13:06:39 -0400 (EDT)
Subject: [PATCH 2/3] net: mediatek: remove incorrect dma_mask assignment
In-Reply-To: <1457964435-2945038-2-git-send-email-arnd@arndb.de>
References: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
 <1457964435-2945038-2-git-send-email-arnd@arndb.de>
Message-ID: <20160314.130639.328854823799037233.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Mar 2016 15:07:11 +0100

> Device drivers should not mess with the DMA mask directly,
> but instead call dma_set_mask() etc if needed.
> 
> In case of the mtk_eth_soc driver, the mask already gets set
> correctly when the device is created, and setting it again
> is against the documented API.
> 
> This removes the incorrect setting.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
