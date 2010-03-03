From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 3 Mar 2010 20:24:57 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267440154.23333.44.camel@e102109-lin.cambridge.arm.com>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267440154.23333.44.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100303202457.GO14694@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> > I wonder if it's time to get a PG_arch_2 :-)
> 
> As an optimisation, I think this would help (rather than always
> invalidating the I-cache in update_mmu_cache or set_pte_at).

If PG_arch_{1,2} are used in the same way on all architectures, when
they are used at all, perhaps they should be renamed :-)

-- Jamie
