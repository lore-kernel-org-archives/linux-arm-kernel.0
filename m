From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 10:23:55 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <20150512180539.4ea5d158@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150512174936.284783d4@free-electrons.com>
 <20150512155824.GJ19927@lunn.ch>
 <20150512180539.4ea5d158@free-electrons.com>
Message-ID: <20150513082355.GT10961@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 06:05:39PM +0200, Thomas Petazzoni wrote:
> Andrew,
> 
> On Tue, 12 May 2015 17:58:24 +0200, Andrew Lunn wrote:
> 
> > A quick grep for marvell,orion, marvell,kirkwood and marvell,dove
> > suggests it should have the - if we want to be consistent with older
> > Marvell devices. As you said, starting with marvell,armanda it gets
> > pretty inconsistent :-(
> 
> Yes, with the "-" would be better IMO.

changed to armada-380-xor, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/2d994dfe/attachment-0001.sig>
