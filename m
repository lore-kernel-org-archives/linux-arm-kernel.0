From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 03 Jan 2012 10:02:52 +0900
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20120102155820.GB29877@amd.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
 <CAHQjnON3XYZ9cAK0kqsY4QzMzESD1wOzxt-fiQCq3TJfDObFiw@mail.gmail.com>
 <20120102155820.GB29877@amd.com>
Message-ID: <005a01ccc9b3$6b6a2870$423e7950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg Roedel wrote:
> 
> On Tue, Jan 03, 2012 at 12:21:30AM +0900, KyongHo Cho wrote:
> > > I still get
> > >
> > > ?LD ? ? ?.tmp_vmlinux1
> > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-
> unknown-linux-gnueabi-ld: no machine record defined
> > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-
> unknown-linux-gnueabi-ld: no machine record defined
> > > /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-
> unknown-linux-gnueabi-ld: no machine record defined
> > > make[1]: *** [.tmp_vmlinux1] Error 1
> > >
> > > when trying to compile ARM/Exynos with 3.2-rc7. Am I doing something
> > > wrong or is this not expected to work?
> > >
> > Do you?
> > Ok. I will check my configuration with linux-next git.
> 
> Compiling my exynos-config with linux-next gives me:
> 
>   CC      arch/arm/kernel/process.o
> In file included from /data/lemmy/linux.trees.git/arch/arm/mach-
> exynos/include/mach/system.h:16:0,
>                  from
/data/lemmy/linux.trees.git/arch/arm/kernel/process.c:64:
> /data/lemmy/linux.trees.git/arch/arm/plat-samsung/include/plat/system-
> reset.h:19:2: error: #error Fix me up
> 
> I better not ask the question how such an #error statement can come
> through to linux-next. But what I can say is that I will not merge
> your code until you guys make sure that your upstream platform code has
> enough quality so that it at least compiles.
> 
Hi Joerg,

I already knew that, Russell added it so that I can take the ARM restart
changes seriously.

Since I pushed exynos restart patches to Russell's patch system so please
kindly ignore it.

> I attach the config I used for my compile-test.
> 
OK, let me check and if any updates, let you know.

Happy New Year.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
