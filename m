From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 02:02:02 +0000
Subject: git pre-commit hook running checkpatch.pl
Message-ID: <20100120020202.GE26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've written a git pre-commit[1] hook which stops any commits happening if
checkpatch.pl reports problems with the patch. Any comments?

[1] http://www.fluff.org/ben/linux/githooks/pre-commit

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100120/e12ebdf8/attachment.sig>
