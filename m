From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jan 2013 08:52:34 +0000
Subject: [BUG] panda board locks up on boot
In-Reply-To: <1359082886.21576.199.camel@gandalf.local.home>
References: <1359082886.21576.199.camel@gandalf.local.home>
Message-ID: <20130125085234.GY23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 10:01:26PM -0500, Steven Rostedt wrote:
> I've recently started testing my work on arm boards and have found that
> they both don't boot under the latest kernel anymore. I already posted
> about my snowball board, but my panda board also locks up.

You need to enable DMA engine and the OMAP DMA engine driver.  I believe
someone was going to work on adding PIO-mode support to the driver but
I suspect as TI's OMAP division is being reorganized, all that is now
uncertain.
