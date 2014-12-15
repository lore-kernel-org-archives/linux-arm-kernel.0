From: davem@davemloft.net (David Miller)
Date: Mon, 15 Dec 2014 11:51:08 -0500 (EST)
Subject: [PATCH 0/2] net/macb: fix multiqueue support patch up
In-Reply-To: <cover.1418651689.git.cyrille.pitchen@atmel.com>
References: <cover.1418651689.git.cyrille.pitchen@atmel.com>
Message-ID: <20141215.115108.1859320509548372496.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Mon, 15 Dec 2014 15:13:30 +0100

> This series of patches is a fixup for the multiqueue support patch.
> 
> The first patch fixes a bug introduced by the multiqueue support patch.
> The second one doesn't fix a bug but simplify the source code by removing
> useless calls to devm_free_irq() since we use managed device resources for
> IRQs.
> 
> They were applied on the net-next tree and tested with a sama5d36ek board.

Series applied, thanks.
