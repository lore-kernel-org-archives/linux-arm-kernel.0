From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 26 Sep 2012 11:17:52 +0300
Subject: [PATCH v2 0/9] add EDO feature for gpmi-nand driver
In-Reply-To: <1347519480-31106-1-git-send-email-b32955@freescale.com>
References: <1347519480-31106-1-git-send-email-b32955@freescale.com>
Message-ID: <1348647472.24309.34.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-13 at 14:57 +0800, Huang Shijie wrote:
> The ONFI nand supports the EDO (extended data out) feature in 
> asynchronous mode when the host controller(such as gpmi-nand)
> uses a tRC of less then 30ns.
> 
> The gpmi can supports this EDO feature.
> This patch set adds the EDO support the gpmi-nand driver.

I did not review this deeply, but the speed improvements are impressive
and patches look good, so pushed to l2-mtd.git, thanks!


-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120926/02e85c15/attachment.sig>
