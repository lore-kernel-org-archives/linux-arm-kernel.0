From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 6 May 2010 11:47:16 -0500
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020893D4@mi8nycmail19.Mi8.com>
References: <201001051459.58621.hartleys@visionengravers.com><1262784693.3181.8034.camel@macbook.infradead.org><BD79186B4FD85F4B8E60E381CAEE1909020893C9@mi8nycmail19.Mi8.com><1262799737.3181.8388.camel@macbook.infradead.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020893D4@mi8nycmail19.Mi8.com>
Message-ID: <0D753D10438DA54287A00B0270842697636ECB4D36@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello David,

Do you know the status of these two patches in linux-next:

commit 7603757993e7ce3e63b2280ccf61d8058b7b2414
Author: H Hartley Sweeten <hartleys@visionengravers.com>
Date:   Tue Jan 5 14:59:58 2010 -0700

    mtd: Remove now-defunct ts7250 nand driver
    
    The ts72xx platform has been updated to use the generic platform nand
    driver (plat_nand.c).  This removes the now-defunct ts7250.c nand driver.
    
    Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
    Cc: Matthieu Crapet <mcrapet@gmail.com>
    Cc: Jesse Off <joff@embeddedARM.com>
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

commit 030d2dd450a628b7a8e31e980af3d05854f68edb
Author: H Hartley Sweeten <hartleys@visionengravers.com>
Date:   Tue Jan 5 14:59:56 2010 -0700

    mtd: Update ep93xx/ts72xx to use generic platform nand driver
    
    Update the ts72xx platform's nand driver support.
    
    This changes the ts72xx platform from using a custom nand driver
    (ts7250.c) to the generic platform nand driver (plat_nand.c).
    
    Tested on TS-7250 with 32MiB NAND.
    
    Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
    Tested-by: Matthieu Crapet <mcrapet@gmail.com>
    Cc: Jesse Off <joff@embeddedARM.com>
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

I have some pending patches for arch/arm/mach-ep93xx/ts72xx.c that
depend on these.

Thanks,
Hartley
