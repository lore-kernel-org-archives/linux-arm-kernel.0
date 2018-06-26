From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jun 2018 11:00:54 -0600
Subject: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA
 vertical flip property
In-Reply-To: <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180626170054.GA1467@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 01:04:47PM +0530, Radhey Shyam Pandey wrote:
> The AXI VDMA core supports Vertical flip in S2MM path when Enable
> Vertical Flip (Advanced tab) is selected. To allow vertical flip
> programming define an optional 'xlnx,enable-vert-flip' channel
> child node property.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
