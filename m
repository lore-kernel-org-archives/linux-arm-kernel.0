From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 22 May 2012 09:33:03 +0300
Subject: [PATCH V2] GPMI-NAND: Define ecc.strength
In-Reply-To: <1337633967-8387-1-git-send-email-marex@denx.de>
References: <1337633967-8387-1-git-send-email-marex@denx.de>
Message-ID: <1337668383.2483.87.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-05-21 at 22:59 +0200, Marek Vasut wrote:
> The ecc.strength wasn't set, resulting in the following crash:
> [    2.550000] kernel BUG at drivers/mtd/nand/nand_base.c:3347!
> [    2.550000] Internal error: Oops - BUG: 0 [#1] ARM

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/03e8cb1d/attachment.sig>
