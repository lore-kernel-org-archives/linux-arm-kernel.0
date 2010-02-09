From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 9 Feb 2010 10:45:44 +0900
Subject: [PATCH] ARM: mach-shmobile: optimize get_irqnr_preamble/and_base
	macros
In-Reply-To: <20100208110254.6001.31943.sendpatchset@rxone.opensource.se>
	<20100208105313.5976.54002.sendpatchset@rxone.opensource.se>
References: <20100208110254.6001.31943.sendpatchset@rxone.opensource.se>
	<20100208105313.5976.54002.sendpatchset@rxone.opensource.se>
Message-ID: <20100209014544.GD14586@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 07:53:13PM +0900, Magnus Damm wrote:
> Optimize the SH-Mobile interrupt assembly macros to avoid
> reloading the INTFLGA register address in case of multiple
> pending interrupts. Kindly pointed out by Russell King.

On Mon, Feb 08, 2010 at 08:02:54PM +0900, Magnus Damm wrote:
> Add support for early console to the SH-Mobile boards.
> 
> Simply perform an early platform probe for "earlyprintk"
> to trigger the early serial console code in sh-sci.c.

I've applied these on top of the others, thanks.
