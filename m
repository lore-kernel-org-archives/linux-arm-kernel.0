From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2010 08:30:06 +0000
Subject: Kernel panic due to page migration accessing memory holes
In-Reply-To: <4B7DEDB0.8030802@codeaurora.org>
References: <4B7C8DC2.3060004@codeaurora.org>
	<20100218100324.5e9e8f8c.kamezawa.hiroyu@jp.fujitsu.com>
	<4B7CF8C0.4050105@codeaurora.org>
	<20100218183604.95ee8c77.kamezawa.hiroyu@jp.fujitsu.com>
	<20100218100432.GA32626@csn.ul.ie>
	<4B7DEDB0.8030802@codeaurora.org>
Message-ID: <20100219083006.GA19649@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 05:47:28PM -0800, Michael Bohan wrote:
> I am actually using the pfn_valid implementation FLATMEM in  
> arch/arm/include/asm/memory.h.  This one is very similar to the  
> asm-generic, and has no knowledge of the holes.

Later kernels have a pfn_valid() which does have hole functionality.
