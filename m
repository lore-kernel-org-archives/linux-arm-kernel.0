From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 15:10:22 +0100
Subject: [PATCH v2] arm/ns9xxx: fix debug macro compilation failure
In-Reply-To: <1279807550.175247.143452709174.1.gpush@pororo>
References: <20100722103834.GH31293@n2100.arm.linux.org.uk>
	<1279807550.175247.143452709174.1.gpush@pororo>
Message-ID: <20100722141022.GT31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 04:05:50PM +0200, Jeremy Kerr wrote:
> We need asm/memory.h for NS9XXX_CSxSTAT_PHYS (via mach/memory.h).

Ok.
