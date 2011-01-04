From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 16:13:55 -0500 (EST)
Subject: [RFC 3/5] ARM: P2V: make head.S use PLAT_PHYS_OFFSET
In-Reply-To: <E1PaDPF-00023h-V5@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPF-00023h-V5@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041612480.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> head.S makes use of PHYS_OFFSET.  When it becomes a variable, the
> assembler won't understand this.  Switch it to use PLAT_PHYS_OFFSET
> for the time being, until this code is properly updated.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Right...  One thing at a time.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
