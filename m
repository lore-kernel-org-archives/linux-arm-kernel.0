From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Sep 2013 17:20:50 -0500
Subject: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
In-Reply-To: <20130920140018.GP25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
 <20130920140018.GP25647@n2100.arm.linux.org.uk>
Message-ID: <20130920222050.GA8763@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Fri, Sep 20, 2013 at 03:00:18PM +0100, Russell King - ARM Linux wrote:
> Another would be if subsystem maintainers are happy that I carry them,
> I can add the acks, and then later on towards the end of the cycle,
> provide a branch subsystem maintainers could pull.
> 
> Or... if you can think of something easier...

I'm happy with the latter method and it's likely that you'll end up
carrying at least some of the patches through your tree anyway.
Please feel free to add my acks to all libata related patches and
carry them through your tree.

Thanks and have fun routing.

-- 
tejun
