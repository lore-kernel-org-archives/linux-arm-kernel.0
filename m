From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 16:10:44 -0500 (EST)
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041607110.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

This might even be a good time to merge such patch now even if the later 
patches don't make it into the next merge window as this would produce 
fewer conflicts later.


Nicolas
