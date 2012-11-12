From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 22:24:22 +0000
Subject: [PATCH] ARM: boot: Fix usage of kecho
In-Reply-To: <CAOMZO5BEi7n76roOAgBFEqvqJybsCeGKZuozqYL5PRL3hJnghQ@mail.gmail.com>
References: <1351103848-30900-1-git-send-email-festevam@gmail.com>
 <201210241928.34303.arnd@arndb.de>
 <CAOMZO5BEi7n76roOAgBFEqvqJybsCeGKZuozqYL5PRL3hJnghQ@mail.gmail.com>
Message-ID: <201211122224.22513.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 November 2012, Fabio Estevam wrote:
> >> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >> >
> >> > Since commit edc88ceb0 (ARM: be really quiet when building with 'make -s') the
> >> > following output is generated when building a kernel for ARM:
> >> >
> >> > echo '  Kernel: arch/arm/boot/Image is ready'
> >> >   Kernel: arch/arm/boot/Image is ready
> >> >   Building modules, stage 2.
> >> > echo '  Kernel: arch/arm/boot/zImage is ready'
> >> >   Kernel: arch/arm/boot/zImage is ready
> >> >
> >> > As per Documentation/kbuild/makefiles.txt the correct way of using kecho is
> >> > '@$(kecho)'.
> >> >
> >> > Make this change so no more unwanted 'echo' messages are displayed.
> >> >
> >> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Acked-by: Nicolas Pitre <nico@linaro.org>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Would this one go via arm-soc tree?

The correct way would be via Russell's tree, but since we're sending bug fix
patches tomorrow through arm-soc and this one is getting embarrassingly old,
I've applied it now.

Thanks for the reminder.

	Arnd
