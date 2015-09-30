From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Sep 2015 12:18:17 +0530
Subject: [PATCH] dmaengine: sun4i: fix unsafe list iteration
In-Reply-To: <1442175353-4433-1-git-send-email-emilio@elopez.com.ar>
References: <1442175353-4433-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20150930064817.GD21690@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 05:15:53PM -0300, Emilio L?pez wrote:
> Currently, sun4i_dma_free_contract iterates over lists and frees memory
> as it goes through them, causing reads to recently freed memory to
> be performed. Fix this by using the safe version of the iterator, so
> freed memory is not referenced at all.

Applied, thanks

-- 
~Vinod
