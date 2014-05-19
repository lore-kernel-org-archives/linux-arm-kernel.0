From: catalin.udma@freescale.com (catalin.udma at freescale.com)
Date: Mon, 19 May 2014 08:24:52 +0000
Subject: [PATCH] arm64: ptrace: fix setting hw breakpoint/watchpoint
In-Reply-To: <20140516162138.GA1694@arm.com>
References: <1399290685-6336-1-git-send-email-catalin.udma@freescale.com>
 <20140516134420.GG12341@arm.com>
 <145f917e71694a30b406ebcaa889e604@BL2PR03MB164.namprd03.prod.outlook.com>
 <20140516162138.GA1694@arm.com>
Message-ID: <2d7e185bf71048e2ab24e1f64f5f099a@BY2PR03MB175.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > As long as the kernel can rely on the registers number sent from GDB,
> > then there is no need for this kernel patch.
> 
> What do you mean? Userspace can pass whatever it likes and the regset
> accessors will do the right thing.
> 
> Will

I meant I agree with you that there is no need to change the kernel with this patch. 
Thank you,
Catalin
