From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 14:06:15 +0200
Subject: [PATCH v4 0/3] mtd: nand: OMAP: ELM error correction support
 for BCH ecc
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
References: <1357286211-5012-1-git-send-email-avinashphilip@ti.com>
 <518397C60809E147AF5323E0420B992E3EA5DFA9@DBDE01.ent.ti.com>
Message-ID: <1358424375.2731.234.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 12:22 +0000, Philip, Avinash wrote:
> > This series is based on linux 3.8-rc2 and tested with [1].
> > Also this patch series depend on [1] for NAND flash device
> > tree data and gpmc nand device tree binding documentation updates.
> > 
> > 1. [PATCH v7 0/5] OMAP GPMC DT bindings
> > http://www.spinics.net/lists/linux-omap/msg83505.html
> > 
> > Tested on am335x-evm for BCH 4 and 8 bit error correction.
> 
> Can you apply this patch series on l2-mtd tree as it will help RBL compatibility
> ecc layout for NAND flash in am335x-platforms and hardware based BCH error
> correction.

OK, I've applied them. I dropped the part that updates the
documentation. Please, handle it separately when Daniel's patches are
in.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/e8aaab3f/attachment.sig>
