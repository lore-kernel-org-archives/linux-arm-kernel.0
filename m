From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 22:01:57 +0000
Subject: {PATCH] BCMRING maintainer change (was RE: [PATCH 02/24] ARM:
	bcmring: update clock source registration)
In-Reply-To: <8628FE4E7912BF47A96AE7DD7BAC0AADDDEFC6EE00@SJEXCHCCR02.corp.ad.broadcom.com>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDs3-0008CQ-FW@rmk-PC.arm.linux.org.uk>
	<9383297B60843144AC17878B479520F1129E584129@SJEXCHCCR01.corp.ad.broadcom.com>
	<8628FE4E7912BF47A96AE7DD7BAC0AADDDEFC6EE00@SJEXCHCCR02.corp.ad.broadcom.com>
Message-ID: <20101214220157.GC24303@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 12:28:40PM -0800, JD (Jiandong) Zheng wrote:
> Hello,
> 
> This is second time I submit this patch because there are complains about Leo 
> Chen's email is not valid and reachable.
> 
> I am Jiandong Zheng working on BCMRING in Broadcom Canada Ltd. I am replacing 
> Leo Chen (leochen at broadcom.com) as " ARM/BCMRING ARM ARCHITECTURE" and "
> ARM/BCMRING MTD NAND DRIVER" maintainer from Broadcom as he is no longer the 
> maintainer of these components.
> 
> Here is the patch to MAINTAINERS file in linux 2.6.36 about this change.
> 
> Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
> 
> Subject: [PATCH] Change bcmring Maintainer list.

I've commited this manually, to fix up the text of the commit message:

    Change bcmring Maintainer list.

    I am Jiandong Zheng working on BCMRING in Broadcom Canada Ltd. I am
    replacing Leo Chen (leochen at broadcom.com) as "ARM/BCMRING ARM
    ARCHITECTURE" and "ARM/BCMRING MTD NAND DRIVER" maintainer from
    Broadcom as he is no longer the maintainer of these components.

    Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
    Acked-by: Scott Branden <sbranden@broadcom.com>

A few notes for future:

1. don't overflow more than 72 characters, unless you're quoting kernel
   messages.
2. The patch summary should be in the email subject, so 'git am' can
   safely parse it.
3. sign-offs should be the last thing before the "---" line before the
   diffstat.
4. commentry about how many times a patch has been sent, and that this
   is a patch should go after the "---" line.
