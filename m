From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Nov 2010 17:46:07 +0100
Subject: [PATCH 00/07] ARM: Common GIC entry macro code V3
In-Reply-To: <20101112082059.27221.52879.sendpatchset@t400s>
References: <20101112082059.27221.52879.sendpatchset@t400s>
Message-ID: <201011121746.07969.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 November 2010, Magnus Damm wrote:
> ARM: Common GIC entry macro code V3
> 
> [PATCH 01/07] ARM: Introduce asm/hardware/entry-macro-gic.S
> [PATCH 02/07] ARM: Use shared GIC entry macros on CNS3XXX
> [PATCH 03/07] ARM: Use shared GIC entry macros on Realview
> [PATCH 04/07] ARM: Use shared GIC entry macros on Tegra
> [PATCH 05/07] ARM: Use shared GIC entry macros on UX500
> [PATCH 06/07] ARM: Use shared GIC entry macros on Vexpress
> [PATCH 07/07] ARM: Use shared GIC entry macros on OMAP
> 
> Put GIC demux code in a common place to avoid duplicated code.
> 

Looks like a very nice cleanup!

	Arnd
