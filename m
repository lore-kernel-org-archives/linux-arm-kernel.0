From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Oct 2009 12:19:21 -0400 (EDT)
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091001101925.50a592fd@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001081216.GA4941@twin.sascha.silbe.org>
	<20091001101925.50a592fd@marrow.netinsight.se>
Message-ID: <alpine.LFD.2.00.0910011218410.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2009, Simon Kagstrom wrote:

> On Thu, 1 Oct 2009 10:12:16 +0200
> Sascha Silbe <sascha-ml-devel-openrd-google@silbe.org> wrote:
> 
> > On Thu, Oct 01, 2009 at 09:04:18AM +0200, Dieter Kiermaier wrote:
> > 
> > > WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
> > > Modules linked in:
> > > [<c002a748>] (unwind_backtrace+0x0/0xd8) from [<c003931c>] 
> > > (warn_slowpath_common+0x4c/0x68)
> > > [<c003931c>] (warn_slowpath_common+0x4c/0x68) from [<c0026844>] 
> > > (cpu_idle+0x74/0xbc)
> > > [<c0026844>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] 
> > > (start_kernel+0x22c/0x27c)
> > > [<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
> > Try the patch from [1], it works for me (uptime 5 days now without the 
> > message above).
> > Disclaimer: I know next to nothing about Linux internals, so can't judge 
> > the quality of the patch. Use at your own risk.
> > 
> > [1] http://patchwork.kernel.org/patch/40871/
> 
> Nice!
> 
> I should add that I've seen this error even without openocd connected,
> so this seems to be a real error. Anyway, I guess this will sooner or
> later be applied (in some form) upstream, so openrd should benefit
> "automatically" from it.
> 
> However, with OpenOCD there are other type of crashes which look very
> random, so I believe those will stay even with this.

Please send me information about those when you can.


Nicolas
