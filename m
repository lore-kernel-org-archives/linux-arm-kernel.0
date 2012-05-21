From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 21 May 2012 11:34:30 +0300
Subject: [PATCH] GPMI-NAND: Define ecc.strength
In-Reply-To: <4FB9FCDE.9070803@freescale.com>
References: <1337571865-8016-1-git-send-email-marex@denx.de>
 <1337587991.2483.65.camel@sauron.fi.intel.com>
 <4FB9FCDE.9070803@freescale.com>
Message-ID: <1337589270.2483.66.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-05-21 at 16:29 +0800, Huang Shijie wrote:
> ? 2012?05?21? 16:13, Artem Bityutskiy ??:
> > On Mon, 2012-05-21 at 05:44 +0200, Marek Vasut wrote:
> >> The ecc.strength wasn't set, resulting in the following crash:
> > How about ccing -stable? Can you find out which commit broke the driver?
> >
> The commit cfbc855b (mtd: nand:add sanity check of ecc strength to 
> nand_scan_tail()

OK, it is not merged upstream yet, so it does not need the -stable tag.
Thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/1b2f72c8/attachment-0001.sig>
