From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 24 Aug 2012 18:08:44 +0300
Subject: [PATCH v2] mtd: physmap_of: Add "no-unaligned-direct-access" DT
 property
In-Reply-To: <1345209752-22938-1-git-send-email-sr@denx.de>
References: <1345209752-22938-1-git-send-email-sr@denx.de>
Message-ID: <1345820924.2848.320.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-17 at 15:22 +0200, Stefan Roese wrote:
> On some platforms (e.g. MPC5200) a direct 1:1 mapping may cause
> problems with JFFS2 usage, as the local bus (LPB) doesn't support
> unaligned accesses as implemented in the JFFS2 code via memcpy().
> By defining "no-unaligned-direct-access", the flash will not be
> exposed directly to the MTD users (e.g. JFFS2) any more.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120824/96bc6e23/attachment.sig>
