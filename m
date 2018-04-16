From: davem@davemloft.net (David Miller)
Date: Mon, 16 Apr 2018 13:43:33 -0400 (EDT)
Subject: [PATCH] net: mediatek: use of_device_get_match_data()
In-Reply-To: <9bf87205f84062580934168774d690d4cd2bf26b.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
 <9bf87205f84062580934168774d690d4cd2bf26b.1523347340.git.ryder.lee@mediatek.com>
Message-ID: <20180416.134333.1584175683168282946.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 16 Apr 2018 10:33:41 +0800

> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call mtk_probe() is to match an entry in
> of_mtk_match[], so match cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to net-next.
