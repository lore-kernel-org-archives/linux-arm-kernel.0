From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Sep 2013 07:16:52 -0500
Subject: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
In-Reply-To: <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
Message-ID: <20130920121652.GA7630@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 12:11:38AM +0100, Russell King wrote:
> The correct way for a driver to specify the coherent DMA mask is
> not to directly access the field in the struct device, but to use
> dma_set_coherent_mask().  Only arch and bus code should access this
> member directly.
> 
> Convert all direct write accesses to using the correct API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tejun Heo <tj@kernel.org>

The patch is pretty widely spread.  I don't mind how it gets routed
but what's the plan?

Thanks.

-- 
tejun
