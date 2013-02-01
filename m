From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 14:57:16 +0000
Subject: [PATCH V2 1/4] DMA: PL330: Add xlate function
In-Reply-To: <1359723116-18173-2-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
 <1359723116-18173-2-git-send-email-padma.v@samsung.com>
Message-ID: <201302011457.16711.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Padmavathi Venna wrote:
> 
> Add xlate to translate the device-tree binding information into
> the appropriate format. The filter function requires the dma
> controller device and dma channel number as filter_params.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
