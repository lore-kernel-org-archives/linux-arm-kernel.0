From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 16:08:27 +0000
Subject: [RFC PATCH 1/2] ARM: kernel: update cpuinfo to print CPU model
 name
In-Reply-To: <1359474865-15408-2-git-send-email-ruslan.bilovol@ti.com>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
 <1359474865-15408-2-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20130129160827.GJ2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 05:54:24PM +0200, Ruslan Bilovol wrote:
> CPU implementer : 0x41
> CPU name        : OMAP4470 ES1.0 HS

Sigh.  No.  Look at what you're doing - look carefully at the above.

"CPU implementer" - 0x41.  That's A.  For ARM Ltd.  ARM Ltd implemented
this CPU.  Did ARM Ltd really implement OMAP4470 ?  I think TI would be
very upset if that were to be the case.

So no, OMAP4470 is _NOT_ a CPU.  It is a SoC.  The CPU inside the SoC is
a collection of ARM Ltd Cortex A9 _CPUs_.

See?  Please, learn what a CPU is as opposed to a SoC.
