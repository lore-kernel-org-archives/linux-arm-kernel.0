From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 May 2014 17:21:38 +0100
Subject: [PATCH] arm64: ptrace: fix setting hw breakpoint/watchpoint
In-Reply-To: <145f917e71694a30b406ebcaa889e604@BL2PR03MB164.namprd03.prod.outlook.com>
References: <1399290685-6336-1-git-send-email-catalin.udma@freescale.com>
 <20140516134420.GG12341@arm.com>
 <145f917e71694a30b406ebcaa889e604@BL2PR03MB164.namprd03.prod.outlook.com>
Message-ID: <20140516162138.GA1694@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 03:35:45PM +0100, catalin.udma at freescale.com wrote:
> Thank you, Will. The gdb patch seems to solve the problem.
> 
> As long as the kernel can rely on the registers number sent from GDB,
> then there is no need for this kernel patch.

What do you mean? Userspace can pass whatever it likes and the regset
accessors will do the right thing.

Will
