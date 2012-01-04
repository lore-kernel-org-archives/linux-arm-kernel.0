From: joerg.roedel@amd.com (Joerg Roedel)
Date: Wed, 4 Jan 2012 16:01:01 +0100
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20120103095527.GI2914@n2100.arm.linux.org.uk>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
 <CAHQjnON3XYZ9cAK0kqsY4QzMzESD1wOzxt-fiQCq3TJfDObFiw@mail.gmail.com>
 <20120102155820.GB29877@amd.com>
 <20120103095527.GI2914@n2100.arm.linux.org.uk>
Message-ID: <20120104150101.GA3492@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 09:55:27AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 02, 2012 at 04:58:20PM +0100, Joerg Roedel wrote:
> > On Tue, Jan 03, 2012 at 12:21:30AM +0900, KyongHo Cho wrote:
> > > > I still get
> > > >
> > > > ?LD ? ? ?.tmp_vmlinux1
> > > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> > > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> > > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> > > > make[1]: *** [.tmp_vmlinux1] Error 1
> > > >
> > > > when trying to compile ARM/Exynos with 3.2-rc7. Am I doing something
> > > > wrong or is this not expected to work?
> > > >
> > > Do you?
> > > Ok. I will check my configuration with linux-next git.
> > 
> > Compiling my exynos-config with linux-next gives me:
> > 
> >   CC      arch/arm/kernel/process.o
> > In file included from /data/lemmy/linux.trees.git/arch/arm/mach-exynos/include/mach/system.h:16:0,
> >                  from /data/lemmy/linux.trees.git/arch/arm/kernel/process.c:64:
> > /data/lemmy/linux.trees.git/arch/arm/plat-samsung/include/plat/system-reset.h:19:2: error: #error Fix me up
> > 
> > I better not ask the question how such an #error statement can come
> > through to linux-next.
> 
> It comes through when I stick it in my tree because of a month of asking
> for help to fix something and getting zero response from the maintainers.
> 
> It's a way to flag to them that they're doing something wrong - and in
> fact something is broken, and that that brokenness will happen at the
> next merge window unless they get off their butt and do something about
> it.

Okay, fine with me if it really will be fixed in 3.3-rc1 :)

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
