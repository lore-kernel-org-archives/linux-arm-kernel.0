From: cjb@laptop.org (Chris Ball)
Date: Fri, 10 Dec 2010 17:21:04 +0000
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
In-Reply-To: <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
References: <20101210162351.GA11798@void.printf.net>
	<1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20101210172104.GA12871@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Dec 10, 2010 at 07:14:32PM +0100, Nicolas Ferre wrote:
> Based on report made by Yauhen in:
> "MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
> I report those changes to the brother driver: atmel-mci.
> 
> So, this patch sets SDIO transfer types: SDIO block and SDIO byte
> transfers instead of using ordinary MMC block transfers.
> It is checking opcode for SDIO CMD53 and setting transfer
> type in MCI_CMDR register properly.
> 
> Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> 
> Hi Chris,
> 
> In addition to the at91_mci multiblock SDIO fix, I add this little one too as
> it concerns the brother driver atmel-mci with same issue.
> 
> I hope that you will be able to queue those fixes to .37-final and stable...

That's fine, this is queued now too.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
