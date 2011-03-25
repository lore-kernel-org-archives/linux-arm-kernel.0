From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Mar 2011 20:27:55 +0000
Subject: how can I cleanly exclude memory from the kernel memory allocator?
In-Reply-To: <20110325173928.GD29359@labbmf-linux.qualcomm.com>
References: <20110324221854.GA29359@labbmf-linux.qualcomm.com>
	<alpine.LFD.2.00.1103241912390.11889@xanadu.home>
	<20110325173928.GD29359@labbmf-linux.qualcomm.com>
Message-ID: <20110325202755.GA13574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 10:39:28AM -0700, Larry Bassel wrote:
> OK, please ignore my previous mail, I see that .fixup can be
> used to adjust tags. It appears to me, however, that using a
> .reserve function calling memblock_reserve will be an
> easier way of doing what I need.

Absolutely.
