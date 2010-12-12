From: cjb@laptop.org (Chris Ball)
Date: Sun, 12 Dec 2010 01:13:44 +0000
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
In-Reply-To: <20101212004203.GG19897@game.jcrosoft.org>
References: <20101210162351.GA11798@void.printf.net>
	<1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
	<20101212004203.GG19897@game.jcrosoft.org>
Message-ID: <20101212011343.GA27152@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 12, 2010 at 01:42:03AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Based on report made by Yauhen in:
> > "MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
> > I report those changes to the brother driver: atmel-mci.
> > 
> > So, this patch sets SDIO transfer types: SDIO block and SDIO byte
> > transfers instead of using ordinary MMC block transfers.
> > It is checking opcode for SDIO CMD53 and setting transfer
> > type in MCI_CMDR register properly.
> > 
> > Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Thanks, pushed to mmc-next and queued for .37/stable.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
