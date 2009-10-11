From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 11 Oct 2009 14:30:21 +0300
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
Message-ID: <1255260621.16942.38.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-06 at 18:19 -0400, H Hartley Sweeten wrote:
> Update the ts72xx platform's nand driver support.
> 
> This changes the ts72xx platform from using a custom nand driver
> (ts7250.c) to the generic platform nand driver (plat_nand.c).
> 
> Tested on TS-7250 with 32MB NAND.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Matthieu Crapet <mcrapet@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-mtd@lists.infradead.org>

Patches do not apply cleanly to current mtd tree. Please, refresh
and resend.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
