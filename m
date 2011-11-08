From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Nov 2011 13:16:10 +0800
Subject: Error for machine_is_m28evk
In-Reply-To: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
Message-ID: <20111108051608.GA6434@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

>From what I see, the compile error below is caused by the missing of
'm28evk' from mach-types.  I checked it has been added into the system
http://www.arm.linux.org.uk/developer/machines/ as ID 3613.  Any idea
how to fix this?

Regards,
Shawn

On Mon, Nov 07, 2011 at 11:49:46PM -0200, Fabio Estevam wrote:
> Hi,
> 
> On a 3.2-rc1 kernel I get the following error when trying to build
> mxs_defconfig:
> 
>   CHK     include/generated/compile.h
>   CC      arch/arm/mach-mxs/clock-mx28.o
> arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
> arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
> function 'machine_is_m28evk'
> make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
> make: *** [arch/arm/mach-mxs] Error 2
> 
