From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 09:02:09 +0800
Subject: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm, shared-override"
 for pl310
In-Reply-To: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
References: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160616010209.GL20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:39:25PM +0800, Peter Chen wrote:
> The imx6 SMP system has the same DMA memory coherency issue [1] with
> pl310 L2 controller. With this shared override bit set, the customer
> reports the DMA coherency issue is gone. Besides, I have tested
> the performance using USB ethernet with/without this bit, it shows
> no difference.
> 
> [1] http://patchwork.ozlabs.org/patch/469362/
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Applied, thanks.
