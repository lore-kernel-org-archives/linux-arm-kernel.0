From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 11 Oct 2009 14:31:18 +0300
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7969@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7969@mi8nycmail19.Mi8.com>
Message-ID: <1255260678.16942.39.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-06 at 18:26 -0400, H Hartley Sweeten wrote:
> The ts72xx platform has been updated to use the generic platform nand
> driver (plat_nand.c).  This removes the now-defunct ts7250.c nand driver.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Matthieu Crapet <mcrapet@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-mtd@lists.infradead.org>
> 
> ---

Would be nice to make sure you have diffstat here, to show that you
actually remove files. I thing git-format-patch does this by default.

Anyway, the patch does not apply, please, refresh against current mtd
tree.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
