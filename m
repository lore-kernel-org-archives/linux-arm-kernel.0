From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 11:58:05 +0000
Subject: [PATCH 0/4] arm64 topology support
In-Reply-To: <20140108102410.GC2927@e102568-lin.cambridge.arm.com>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <20140107180545.GB14603@e102568-lin.cambridge.arm.com>
 <20140107182355.GL31886@sirena.org.uk>
 <20140108102410.GC2927@e102568-lin.cambridge.arm.com>
Message-ID: <20140108115805.GP31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 10:24:10AM +0000, Lorenzo Pieralisi wrote:

> Nothing prevents us from merging code as it is and consolidate it when
> needed, provided we will do that.

OK, that sounds good.

> > get_cpu_for_node() could probably be shifted into a header, perhaps when
> > there's other users though.

> Right.

Actually there's a bit of an issue with pulling that into core code -
some of the PowerPC systems use the thread ID but apparently not in a
way that's entirely compatible with what ARM is doing from a first
glance.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/d4f17cd8/attachment.sig>
