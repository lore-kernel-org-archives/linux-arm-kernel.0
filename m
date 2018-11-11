From: vkoul@kernel.org (Vinod Koul)
Date: Sun, 11 Nov 2018 14:54:24 +0530
Subject: [PATCH] dmaengine: sa11x0: unexport sa11x0_dma_filter_fn and
 clean up
In-Reply-To: <E1gK1fK-0000z2-Fo@rmk-PC.armlinux.org.uk>
References: <E1gK1fK-0000z2-Fo@rmk-PC.armlinux.org.uk>
Message-ID: <20181111092424.GC12092@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-11-18, 13:45, Russell King wrote:
> As we now have no users of sa11x0_dma_filter_fn() in the tree, we can
> unexport this function, and remove the now unused header file.

Applied, thanks

-- 
~Vinod
