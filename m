From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 24 Dec 2010 10:58:59 +0900
Subject: [PATCH] dma_declare_coherent_memory: push ioremap() up to caller
In-Reply-To: <201012240020.37208.jkrzyszt@tis.icnet.pl>
References: <201012240020.37208.jkrzyszt@tis.icnet.pl>
Message-ID: <20101224015858.GG28151@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 12:20:32AM +0100, Janusz Krzysztofik wrote:
> Tested on ARM OMAP1 based Amstrad Delta with a WIP OMAP1 camera patch, 
> patterned upon two mach-mx3 machine types which already try to use the 
> dma_declare_coherent_memory() method for reserving a region of system 
> RAM preallocated with another dma_alloc_coherent(). Compile tested for 
> all modified files except arch/sh/drivers/pci/fixups-dreamcast.c.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

The arch/sh/drivers/pci/fixups-dreamcast.c build fine.

Acked-by: Paul Mundt <lethal@linux-sh.org>
