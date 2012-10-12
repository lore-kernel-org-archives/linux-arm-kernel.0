From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 12 Oct 2012 15:01:49 +0100
Subject: [PATCH] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <201210121353.16798.arnd@arndb.de>
References: <1349966545-19340-1-git-send-email-lee.jones@linaro.org>
 <20121012134542.GH12567@gmail.com>
 <20121012134813.GK21164@n2100.arm.linux.org.uk>
 <201210121353.16798.arnd@arndb.de>
Message-ID: <20121012140149.GJ12567@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Oct 2012, Arnd Bergmann wrote:

> On Friday 12 October 2012, Russell King - ARM Linux wrote:
> > > root at ME:/ cat /sys/kernel/debug/boottime/bootgraph
> > > [    0.185254] calling  splash+0x0/0x0
> > > [    2.984335] initcall splash+0x0/0x0 returned 0 after 2799 msecs.
> > > [    2.984335] calling  autoboot_delay+0x0/0x0
> > > [    4.089513] initcall autoboot_delay+0x0/0x0 returned 0 after 1105 msecs.
> > > [    4.089513] calling  load_kernel+0x0/0x0
> > > [    4.239174] initcall load_kernel+0x0/0x0 returned 0 after 149 msecs.
> > > [    4.239174] calling  boot_kernel+0x0/0x0
> > > [    4.276260] initcall boot_kernel+0x0/0x0 returned 0 after 37 msecs.
> > > [    4.276260] calling  uncompress_ll_init+0x0/0x0
> > > [    4.276260] initcall uncompress_ll_init+0x0/0x0 returned 0 after 0 msecs.
> > > [    4.276260] Freeing init memory: 0K
> > 
> > Umm, what happened to sysfs not becoming procfs v2?  I thought we had
> > a fairly strict requirement for "one value per file and not nicely
> > formatted" for sysfs?
> > 
> 
> I was thinking the same thing at first, but then I noticed it's actually
> debugfs, which has no such rules.

Right. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
