From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 10:12:01 +0900
Subject: [PATCH v2] ARM: shmobile: marzen-reference: use irqpin for lan
In-Reply-To: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
References: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130410011201.GC11105@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:10:13AM +0900, Simon Horman wrote:
> This corrects the configuration of the SMSC lan controller
> to use the newly added irqpin as its IRQ source.
> 
> Previously the lan controller did not work. Now it does.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Queued up in the marzen-boards branch.
