From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Oct 2012 08:14:27 +0200
Subject: [PATCH] Add FDT support to Pandaboard initialization
In-Reply-To: <1351363800-28744-1-git-send-email-const@MakeLinux.com>
References: <1351363800-28744-1-git-send-email-const@MakeLinux.com>
Message-ID: <20121029061427.GP17570@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 08:50:00PM +0200, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Problem:
> - FDT is supported only by generic OMAP board initialization in arch/arm/mach-omap2/board-generic.c and lacks some configurations, which are not yet configured in FDT (USB for example).
> Solution:
> - arch/arm/mach-omap2/board-omap4panda.c supports initialization with FDT and without it.
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

NAK, the whole idea of DT is to drop board-*.c. It would be best to see
the "missing initialization" being added to board-generic/dts files.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/c0b25a4f/attachment.sig>
