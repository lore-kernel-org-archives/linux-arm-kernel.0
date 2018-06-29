From: vkoul@kernel.org (Vinod)
Date: Fri, 29 Jun 2018 14:21:05 +0530
Subject: [PATCH 0/2] Enable VDMA S2MM vertical flip support
In-Reply-To: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20180629085105.GC22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-18, 13:04, Radhey Shyam Pandey wrote:
> The AXI VDMA core supports Vertical Flip with S2MM as the path when
> Enable Vertical Flip (Advanced tab) is selected. This patch series add
> DT property for vertical flip and program its state in VDMA start_transfer.

Applied both, thanks

-- 
~Vinod
