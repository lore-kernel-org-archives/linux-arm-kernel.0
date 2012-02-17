From: richard.weinberger@gmail.com (richard -rw- weinberger)
Date: Fri, 17 Feb 2012 21:27:53 +0100
Subject: ARM: __enabled_CONFIG_NUMA undeclared
In-Reply-To: <CAOMZO5CarXUJ1XVJMWCEt1AXvnE5Gvunou_8nydjLmPVkZERMA@mail.gmail.com>
References: <CAOMZO5CarXUJ1XVJMWCEt1AXvnE5Gvunou_8nydjLmPVkZERMA@mail.gmail.com>
Message-ID: <CAFLxGvwSVq1GhSVnHyt9jKTy4cvZ4a0hQUau6Kh36fQuw9bdjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 9:12 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Building today's linux-next for ARM:
>
> ?CC ? ? ?arch/arm/kernel/asm-offsets.s
> In file included from include/linux/mm.h:8:0,
> ? ? ? ? ? ? ? ? from arch/arm/kernel/asm-offsets.c:14:
> include/linux/gfp.h: In function 'gfp_zonelist':
> include/linux/gfp.h:267:1: error: '__enabled_CONFIG_NUMA' undeclared
> (first use in this function)
> include/linux/gfp.h:267:1: note: each undeclared identifier is
> reported only once for each function it appears in
> include/linux/gfp.h:267:1: error: '__enabled_CONFIG_NUMA_MODULE'
> undeclared (first use in this function)
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
>
> , which is caused by commit 053361e1a (mm: replace NUMA_BUILD with
> IS_ENABLED(CONFIG_NUMA)

UML is affected too.

-- 
Thanks,
//richard
