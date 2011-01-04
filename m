From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 16:12:28 -0500 (EST)
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041611350.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> As PHYS_OFFSET will be becoming a variable, we can't have it used in
> initializers nor assembly code.  Replace those in generic code with
> a run-time initialization.  Replace those in platform code using the
> individual platform specific PLAT_PHYS_OFFSET.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Same comment as for 1/5.


Nicolas
