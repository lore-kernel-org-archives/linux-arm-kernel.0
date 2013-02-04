From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 04 Feb 2013 10:08:46 +0200
Subject: [PATCH] mtd: gpmi: fix a dereferencing freed memory error
In-Reply-To: <1358929253-29143-1-git-send-email-b32955@freescale.com>
References: <1358929253-29143-1-git-send-email-b32955@freescale.com>
Message-ID: <1359965326.13791.13.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-23 at 16:20 +0800, Huang Shijie wrote:
> The patch "490e280 mtd: gpmi-nand: Convert to module_platform_driver()"
> introduced a "dereferencing freed memory" error.
> 
> This patch fixes it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/eafb7a5e/attachment.sig>
