From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 08 Jun 2010 11:04:15 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100607215224.GD7220@n2100.arm.linux.org.uk>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<20100607202701.GA14529@oksana.dev.rtsoft.ru>
	<1275944757.11056.16.camel@toshiba-laptop>
	<20100607215224.GD7220@n2100.arm.linux.org.uk>
Message-ID: <1275991455.2127.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-07 at 22:52 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 07, 2010 at 10:05:57PM +0100, Catalin Marinas wrote:
> > But as I said, we already have patches to change the kernel R/W
> > permission for RO user pages.
> 
> ... but they introduce their own problem.

And these problem are ...

-- 
Catalin
