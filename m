From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 24 Aug 2012 17:23:50 +0300
Subject: [PATCH] kconfig: remove CONFIG_MTD_NAND_VERIFY_WRITE
In-Reply-To: <1345021930-5033-1-git-send-email-b32955@freescale.com>
References: <1345021930-5033-1-git-send-email-b32955@freescale.com>
Message-ID: <1345818230.2848.315.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-15 at 17:12 +0800, Huang Shijie wrote:
> Just as Artem suggested:
> 
> "Both UBI and JFFS2 are able to read verify what they wrote already.
> There are also MTD tests which do this verification. So I think there
> is no reason to keep this in the NAND layer, let alone wasting RAM in
> the driver to support this feature."
> 
> So kill MTD_NAND_VERIFY_WRITE entirely. Please see the patch:
> http://lists.infradead.org/pipermail/linux-mtd/2012-August/043189.html
>   
> This patch removes the CONFIG_MTD_NAND_VERIFY_WRITE in the defconfigs.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120824/32689b6e/attachment.sig>
