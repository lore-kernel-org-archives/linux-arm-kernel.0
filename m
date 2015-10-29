From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 29 Oct 2015 10:42:41 +0900
Subject: [PATCH v2 0/2] dmaengine: hdmac: Add scatter-gathered memset
 support
In-Reply-To: <1445506860-22619-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445506860-22619-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151029014236.GC18368@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 11:40:58AM +0200, Maxime Ripard wrote:
> Hi Vinod,
> 
> Here is a patch serie that adds support in the Atmel HDMAC for memset
> over a discontiguous memory area.
> 
> Just like for the memset, it's used on those SoCs to support
> framebuffer related operations that cannot be performed either by the
> display engine or the (non-existent) GPU.

Applied, thanks

-- 
~Vinod
