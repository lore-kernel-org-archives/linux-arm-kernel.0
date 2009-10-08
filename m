From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2009 23:38:16 +0100
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7CDB@mi8nycmail19.Mi8.com>
References: <20091008213425.GA16880@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7CDB@mi8nycmail19.Mi8.com>
Message-ID: <20091008223816.GA18133@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2009 at 06:32:49PM -0400, H Hartley Sweeten wrote:
> Did you see the locking I added for clk_enable / clk_disable?  Will that
> cover the concern you had earlier? 

Yes, and yes.
