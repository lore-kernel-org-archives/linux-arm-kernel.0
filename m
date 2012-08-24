From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 24 Aug 2012 17:23:19 +0300
Subject: [PATCH] mtd: kill MTD_NAND_VERIFY_WRITE
In-Reply-To: <1344998325-3279-1-git-send-email-shijie8@gmail.com>
References: <1344998325-3279-1-git-send-email-shijie8@gmail.com>
Message-ID: <1345818199.2848.314.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-08-14 at 22:38 -0400, Huang Shijie wrote:
> Just as Artem suggested:
> 
> "Both UBI and JFFS2 are able to read verify what they wrote already.
> There are also MTD tests which do this verification. So I think there
> is no reason to keep this in the NAND layer, let alone wasting RAM in
> the driver to support this feature."
> 
> So kill MTD_NAND_VERIFY_WRITE entirely.
> 
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120824/b44b8d33/attachment-0001.sig>
