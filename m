From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jun 2010 22:52:24 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <1275944757.11056.16.camel@toshiba-laptop>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<20100607202701.GA14529@oksana.dev.rtsoft.ru>
	<1275944757.11056.16.camel@toshiba-laptop>
Message-ID: <20100607215224.GD7220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 10:05:57PM +0100, Catalin Marinas wrote:
> But as I said, we already have patches to change the kernel R/W
> permission for RO user pages.

... but they introduce their own problem.
