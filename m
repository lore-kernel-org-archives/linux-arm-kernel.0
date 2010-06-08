From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 8 Jun 2010 16:58:19 +0800
Subject: [RFC] pxa: about ac97 for public use
Message-ID: <AANLkTinVD25v8HyOHDPWjpev7yp_tFqy_8S8Wa5njgYs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Now, our pxa168 ac97 driver need the regs-ac97.h file support, but
this file was located in mach-pxa/include.
Should we move the public 'regs-ac97.h' to plat-pxa/ or create a new
one in mach-mmp/include for pxa168 ac97 driver?

-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
