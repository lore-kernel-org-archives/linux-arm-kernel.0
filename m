From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 22:30:53 +0000
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <alpine.LFD.2.00.1101041607110.22191@xanadu.home>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041607110.22191@xanadu.home>
Message-ID: <20110105223053.GN8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 04:10:44PM -0500, Nicolas Pitre wrote:
> On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> 
> > This uncouple PHYS_OFFSET from the platform definitions, thereby
> > facilitating run-time computation of the physical memory offset.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This might even be a good time to merge such patch now even if the later 
> patches don't make it into the next merge window as this would produce 
> fewer conflicts later.

I think waiting might be in order - MXC conflicts with this patch set
and needs rechecking to make sure it's right.  ATM, it's had no
visibility in linux-next.

However, it makes sense to get the likely to conflict bits in sooner
rather than later - or I need to publish them from my git tree in a
stable form so that people can include those changes in their patchsets.
