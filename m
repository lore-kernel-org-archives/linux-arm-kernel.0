From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 10:35:02 +0000
Subject: [PATCH] ARM: Kota2 mach-type update fix
In-Reply-To: <87zkflg999.wl%kuninori.morimoto.gx@renesas.com>
References: <20111122060857.23951.50598.sendpatchset@w520>
 <20111122092615.GA26411@linux-sh.org>
 <CANqRtoTvMpivHN0tZVTEY6SfkBrNLpu=rkRXUXKJG4J0UNCzhg@mail.gmail.com>
 <20111124082342.GD32112@linux-sh.org>
 <87zkflg999.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20111124103502.GP9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 01:28:06AM -0800, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> > > >> From: Magnus Damm <damm@opensource.se>
> > > >>
> > > >> This patch adds kota2 to the in-kernel ARM mach-type file.
> > > >>
> > > >> Basic board support is included in 3.2-rc and the mach-type
> > > >> has been registered in the ARM machine repository as
> > > >>
> > > >> 3616 Renesas SH-Mobile kota2.x Board kota2 Yusuke Goda mainlined
> > > >>
> > > >> The file arch/arm/tools/mach-types is however missing Kota2
> > > >> which makes build of sh73a0 based boards fail with:
> > > >>
> > > >> arch/arm/mach-shmobile/platsmp.c: In function 'shmobile_smp_get_core_count':
> > > >> arch/arm/mach-shmobile/platsmp.c:28:2: error: implicit declaration of function 'machine_is_kota2'
> > > >> make[1]: *** [arch/arm/mach-shmobile/platsmp.o] Error 1
> > > >>
> > > >> arch/arm/mach-shmobile/board-kota2.c:448:136: error: 'MACH_TYPE_KOTA2' undeclared here (not in a function)
> > > >> make[1]: *** [arch/arm/mach-shmobile/board-kota2.o] Error 1
> > > >> make: *** [arch/arm/mach-shmobile] Error 2
> > > >>
> > > >> Signed-off-by: Magnus Damm <damm@opensource.se>
> > > >> ---
> (snip)
> > > Russell, do you mind if we update the mach-type file to include Kota2?
> > > It's already registered via the web interface.
> > > 
> > I'll add it with Russell's Acked-by, otherwise we'll simply have to wait
> > for the next batch of mach-types updates.
> 
> Can I add A1 bonito mach-type too?
> I can not find it either
> 
> 
> 3623 	Renesas R-Mobile A1 EVB 	bonito 	Kuninori Morimoto

No, because it's not in the kernel source.
