From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sun, 11 Oct 2009 17:18:17 -0400
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <1255260678.16942.39.camel@localhost>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7969@mi8nycmail19.Mi8.com>
	<1255260678.16942.39.camel@localhost>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7E58@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 11, 2009 4:31 AM, Artem Bityutskiy wrote:
> On Tue, 2009-10-06 at 18:26 -0400, H Hartley Sweeten wrote:
>> The ts72xx platform has been updated to use the generic platform nand
>> driver (plat_nand.c).  This removes the now-defunct ts7250.c nand driver.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Matthieu Crapet <mcrapet@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: <linux-arm-kernel@lists.infradead.org>
>> Cc: <linux-mtd@lists.infradead.org>
>> 
>> ---
>
> Would be nice to make sure you have diffstat here, to show that you
> actually remove files. I thing git-format-patch does this by default.
>
> Anyway, the patch does not apply, please, refresh against current mtd
> tree.

Same issue as the previous patch.  These files match in the mtd tree 
and 2.6.32-rc3.

I will rebase on the mtd tree and repost with a diffstat.

Regards,
Hartley
