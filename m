From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 Mar 2017 12:18:00 +0000
Subject: [PATCH v2 4/7] mfd: syscon: atmel-smc: Remove unused
 helpers/macros
In-Reply-To: <20170316113438.790bfb67@bbrezillon>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
 <1489653034-17777-5-git-send-email-boris.brezillon@free-electrons.com>
 <20170316101627.ecp63pr5v6l4neam@dell>
 <20170316113438.790bfb67@bbrezillon>
Message-ID: <20170316121800.swpt6d5oti3flpqj@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Mar 2017, Boris Brezillon wrote:

> Hi Lee,
> 
> On Thu, 16 Mar 2017 10:16:27 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Thu, 16 Mar 2017, Boris Brezillon wrote:
> > 
> > > All macros prefixed with AT91[SAM9]_SMC have been replaced by equivalent
> > > definitions prefixed with ATMEL_SMC, and the at91sam9_smc_xxxx() helpers
> > > are no longer used.
> > > Drop these definitions before someone starts using them again.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  include/linux/mfd/syscon/atmel-smc.h | 152 -----------------------------------
> > >  1 file changed, 152 deletions(-)  
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > What is the plan for this set?
> > 
> > I only see 2 patches.
> 
> You mean, you only see 2 patches in your Inbox (that would be weird,
> because you're in the CC list of all patches), or only 2 patches that
> should go in your tree?

I meant the former, but another pull down of my mail grabbed the
remaining patches.

> > Can they both be applied?
> 
> All patches should go through the same tree, because changes in
> drivers/memory/atmel-ebi.c are depending on changes done in the MFD
> subsystem.
> 
> If Nicolas is okay with that, maybe you can take everything through the
> MFD tree (I don't expect any conflicts in drivers/memory/atmel-ebi.c).

That would be okay by me.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
