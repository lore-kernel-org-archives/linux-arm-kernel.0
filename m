From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 13 Jun 2011 14:48:06 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring proc_info
	structs
In-Reply-To: <20110613131257.GA13643@n2100.arm.linux.org.uk>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
	<20110609173836.GF24424@n2100.arm.linux.org.uk>
	<20110610085752.GA2129@arm.com>
	<20110612082220.GB10283@n2100.arm.linux.org.uk>
	<20110612151422.GJ10283@n2100.arm.linux.org.uk>
	<20110613131008.GA2093@arm.com>
	<20110613131257.GA13643@n2100.arm.linux.org.uk>
Message-ID: <20110613134806.GA8498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 02:12:57PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 13, 2011 at 02:10:08PM +0100, Dave Martin wrote:
> > Using macros such as you suggest would force a consistent naming on
> > different CPUs' helper functions, which actually seems rather a good thing.
> > A possible downside is that the relationship between those functions
> > and the macro becomes invisible in proc-*.S (though a very brief comment
> > or two could easibly address that).
> 
> The consistent naming is already required for the !MULTI_CPU, etc.
> Same for the cache and tlb structs.
> 
> The processor structure has less strict requirements though.

OK, well I might have a go at this for the CPU func structs at some point,
and see how it turns out.

Cheers
---Dave
