From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 15:31:49 +0000
Subject: linux-next: manual merge of the ixp4xx tree with the arm-soc tree
In-Reply-To: <20120920163227.c6d8f1559b9cde971a376abf@canb.auug.org.au>
References: <20120920163227.c6d8f1559b9cde971a376abf@canb.auug.org.au>
Message-ID: <201209201531.50167.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 September 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the ixp4xx tree got conflicts in
> arch/arm/mach-ixp4xx/common.c and
> arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h between commit
> 13ec32f47cb4 ("ARM: ixp4xx: use __iomem pointers for MMIO") from the
> arm-soc tree and commits 43690ab7543a ("IXP4xx: Always ioremap() Queue
> Manager MMIO region at boot") and f62736b567ff ("IXP4xx: map CPU config
> registers within VMALLOC region") from the ixp4xx tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Ok, thanks!

This conflict will go away once Krzysztof's patches make it into arm-soc.

	Arnd
