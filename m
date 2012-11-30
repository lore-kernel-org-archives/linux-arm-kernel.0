From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 30 Nov 2012 23:47:14 +0530
Subject: [PATCH v2] dmaengine: sirf: enable the driver support new
 SiRFmarco SoC
In-Reply-To: <1351781683-8946-1-git-send-email-21cnbao@gmail.com>
References: <1351781683-8946-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1354299434.7077.77.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-01 at 22:54 +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> The driver supports old up SiRFprimaII SoCs, this patch makes it
> support
> the new SiRFmarco as well.
> SiRFmarco, as a SMP SoC, adds new DMA_INT_EN_CLR and
> DMA_CH_LOOP_CTRL_CLR
> registers, to disable IRQ/Channel, we should write 1 to the
> corresponding
> bit in the two CLEAR register.
Applied, thanks

-- 
Vinod Koul
Intel Corp.
