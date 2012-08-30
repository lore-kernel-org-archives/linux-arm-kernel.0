From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 30 Aug 2012 09:29:05 +0300
Subject: [PATCH resend] i.MX53 Nand support
In-Reply-To: <1346226019-23560-1-git-send-email-s.hauer@pengutronix.de>
References: <1346226019-23560-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346308145.2848.529.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-29 at 09:40 +0200, Sascha Hauer wrote:
> Hi All,
> 
> The following patches add i.MX53 and dt support to mxc_nand. This
> is only a resent based on v3.6-rc3 as it seems this series slipped
> through the cracks last time I posted it.
> 
> So Artem, if there are no objections, please consider applying up to
> 3/4, I would then take 4/4 through my tree.

Please, take a look at the l2-mtd.git tree, I already have all these
patches. Actually, they are already in dwmw2's tree, the and were
supposed to be merged already, but unfortunately the merge window was
missed because (a) dwmw2 did not send a pull request early enough and
(b) Linus decided to punish late pull-request senders and closed the
merge window 2 days earlier than usually.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/63b16be4/attachment.sig>
