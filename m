From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 19:28:33 +0000
Subject: [PATCH] ARM: boot: Fix usage of kecho
In-Reply-To: <alpine.LFD.2.02.1210241444090.16518@xanadu.home>
References: <1351103848-30900-1-git-send-email-festevam@gmail.com>
 <alpine.LFD.2.02.1210241444090.16518@xanadu.home>
Message-ID: <201210241928.34303.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Nicolas Pitre wrote:
> On Wed, 24 Oct 2012, Fabio Estevam wrote:
> 
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Since commit edc88ceb0 (ARM: be really quiet when building with 'make -s') the
> > following output is generated when building a kernel for ARM:
> > 
> > echo '  Kernel: arch/arm/boot/Image is ready'
> >   Kernel: arch/arm/boot/Image is ready
> >   Building modules, stage 2.
> > echo '  Kernel: arch/arm/boot/zImage is ready'
> >   Kernel: arch/arm/boot/zImage is ready
> > 
> > As per Documentation/kbuild/makefiles.txt the correct way of using kecho is
> > '@$(kecho)'.
> > 
> > Make this change so no more unwanted 'echo' messages are displayed.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry for this, I really should have tested without '-s'.

	Arnd
