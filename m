From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 16:35:43 +0200
Subject: [PATCH] mtd: gpmi: dump the BCH registers
In-Reply-To: <1358147969-31878-1-git-send-email-b32955@freescale.com>
References: <1358147969-31878-1-git-send-email-b32955@freescale.com>
Message-ID: <1358433343.2731.254.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-14 at 15:19 +0800, Huang Shijie wrote:
> Dump the BCH registers in gpmi_dump_info().
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/gpmi-nand/bch-regs.h |    2 ++
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c |    5 +++++
>  2 files changed, 7 insertions(+), 0 deletions(-)

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/9caddbc5/attachment.sig>
