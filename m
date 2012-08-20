From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 22:24:24 +0800
Subject: [PATCH 5/6] ARM: mxs: select SPARSE_IRQ
In-Reply-To: <1345472400-31262-6-git-send-email-shawn.guo@linaro.org>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
 <1345472400-31262-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120820142422.GK24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 10:19:59PM +0800, Shawn Guo wrote:
> With icoll and gpio interrupt controllers adopt irqdomain support and
> all interrupt nubmers are retrieved from device tree, it's save to

s/save/safe

> select SPARSE_IRQ for mxs now.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
