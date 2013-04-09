From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Apr 2013 21:52:56 +0900
Subject: [PATCH] ARM: shmobile: marzen-reference: use irqpin for lan
In-Reply-To: <1365125960-25753-1-git-send-email-horms+renesas@verge.net.au>
References: <1365125960-25753-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130409125256.GG15412@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 10:39:20AM +0900, Simon Horman wrote:
> This corrects the configuration of the SMSC lan controller
> to use the newly added irqpin as its IRQ source.
> 
> Previously the lan controller did not work. Now it does.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Queued up in the boards-marzen branch.
