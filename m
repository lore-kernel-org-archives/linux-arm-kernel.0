From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 16:01:14 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140717145838.GJ18203@arm.com>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140717115937.GF18203@arm.com>
 <20140717145002.GW17528@sirena.org.uk>
 <20140717145838.GJ18203@arm.com>
Message-ID: <20140717150114.GX17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 03:58:38PM +0100, Catalin Marinas wrote:
> On Thu, Jul 17, 2014 at 03:50:02PM +0100, Mark Brown wrote:

> > What would be better would be if we could get the two trees synced up,
> > in this case something like picking the audit change up in the ARMv8
> > tree (or vice versa) seems like it'd be quick and easy since it looks
> > like neither tree uses topic branches.

> It's not ideal indeed but applying this patch on my tree would break it.
> So we need a common base where the audit API is changed, guaranteed not
> to be rebased so that I can merge it in the arm64 for-next/core branch.

> Do you know which tree commit 3efe33f5d2 is in? I assume some tip
> branch?

It's the head commit in Eric's audit tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/97456dab/attachment-0001.sig>
