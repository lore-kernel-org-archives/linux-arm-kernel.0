From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 24 Aug 2015 19:54:25 +0530
Subject: [PATCH v3] dmaengine: hdmac: Add memset capabilities
In-Reply-To: <1440408075-26438-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1440408075-26438-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150824142425.GL13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:21:15AM +0200, Maxime Ripard wrote:
> Just like for the XDMAC, the SoCs that embed the HDMAC don't have any kind
> of GPU, and need to accelerate a few framebuffer-related operations through
> their DMA controller.
> 
> However, unlike the XDMAC, the HDMAC doesn't have the memset capability
> built-in. That can be easily emulated though, by doing a transfer with a
> fixed address on the variable that holds the value we want to set.

Applied, thanks

-- 
~Vinod
