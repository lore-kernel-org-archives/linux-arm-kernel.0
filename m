From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Jul 2010 14:06:19 +0200
Subject: machine definition for colibri-pxa3xx
In-Reply-To: <201007081236.39550.pieterg@gmx.com>
References: <201007081236.39550.pieterg@gmx.com>
Message-ID: <201007081406.20038.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 12:36:39 pieterg napsal(a):
> At the moment, colibri-pxa300.c as well as colibri-pxa320.c have their own
> machine definition.
> 
> However, running a kernel built with CONFIG_MACH_COLIBRI300 and
> CONFIG_MACH_COLIBRI320 on a colibri 300 or 310, it will match the 320
> machine definition, and therefore use colibri-pxa320.c.

Huh? Your bootloader is messed up? What bootloader do you use ?
> 
> I believe it's not possible to differentiate colibri pxa3xx based on
> machine definitions, but only by checking the their cpu.
> 
> Wouldn't it make sense to place a single "Toradex Colibri PXA3xx" machine
> definition in colibri-pxa3xx.c, and use cpu_is_pxa3nn to do cpu specific
> initialisation?
> This is exactly how things are done for zylonite by the way.
> 
> I have some colibri pxa310 patches, but we need a working machine detection
> before they will actually do anything.
> 
> Rgds, Pieter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
