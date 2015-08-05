From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 5 Aug 2015 10:56:56 +0530
Subject: [PATCH v2 2/2] dmaengine: hdmac: Add memset capabilities
In-Reply-To: <1437381778-19108-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437381778-19108-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150805052656.GO11789@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 10:42:58AM +0200, Maxime Ripard wrote:
> Just like for the XDMAC, the SoCs that embed the HDMAC don't have any kind
> of GPU, and need to accelerate a few framebuffer-related operations through
> their DMA controller.
> 
> However, unlike the XDMAC, the HDMAC doesn't have the memset capability
> built-in. That can be easily emulated though, by doing a transfer with a
> fixed adress on the variable that holds the value we want to set.
typo  ^^^^^^^^

Applied, with typo fixed

-- 
~Vinod
