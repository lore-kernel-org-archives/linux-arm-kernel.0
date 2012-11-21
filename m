From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:58:48 +0000
Subject: [PATCH 238/493] mtd: remove use of __devinit
In-Reply-To: <1353349642-3677-238-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-238-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121115848.GI3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:23:07PM -0500, Bill Pemberton wrote:
>  drivers/mtd/maps/pismo.c               | 14 +++++++-------
>  drivers/mtd/maps/sa1100-flash.c        |  5 ++---

For these two,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
