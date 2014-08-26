From: davem@davemloft.net (David Miller)
Date: Mon, 25 Aug 2014 17:26:10 -0700 (PDT)
Subject: [PATCH v6 3/4] net: moxa: synchronize DMA memory
In-Reply-To: <1408976552-15659-1-git-send-email-jonas.jensen@gmail.com>
References: <1408976552-15659-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140825.172610.496537032439062803.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Mon, 25 Aug 2014 16:22:32 +0200

> DMA memory should be synchronized before data is passed
> to/from controller.
> 
> Add dma_sync_single_for_cpu(.., DMA_FROM_DEVICE) to RX path
> and dma_sync_single_for_device(.., DMA_TO_DEVICE) to TX path.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied.
