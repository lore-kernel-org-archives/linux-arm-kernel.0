From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 3 Jul 2012 13:18:48 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
Message-ID: <CACKLOr3nnd0-3txJo70nU6SptjHta1bDdUNAkHUAL8VAA=sd2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tag 'imx-clk-common-fixes' of repository
'git://git.pengutronix.de/git/imx/linux-2.6.git' is broken too:

  CC      arch/arm/mach-imx/cpu-imx27.o
  CC      arch/arm/mach-imx/pm-imx27.o
  CC      arch/arm/mach-imx/clk-imx27.o
In file included from arch/arm/mach-imx/clk-imx27.c:11:
arch/arm/mach-imx/clk.h: In function 'imx_clk_mux':
arch/arm/mach-imx/clk.h:73: warning: passing argument 3 of
'clk_register_mux' from incompatible pointer type
include/linux/clk-provider.h:255: note: expected 'char **' but
argument is of type 'const char **'
arch/arm/mach-imx/clk.h: In function 'imx_clk_fixed_factor':
arch/arm/mach-imx/clk.h:79: error: implicit declaration of function
'clk_register_fixed_factor'
arch/arm/mach-imx/clk.h:80: warning: return makes pointer from integer
without a cast
arch/arm/mach-imx/clk-imx27.c: In function 'mx27_clocks_init':
arch/arm/mach-imx/clk-imx27.c:189: error: implicit declaration of
function 'clk_register_clkdev'
make[1]: *** [arch/arm/mach-imx/clk-imx27.o] Error 1
make: *** [arch/arm/mach-imx] Error 2



-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
