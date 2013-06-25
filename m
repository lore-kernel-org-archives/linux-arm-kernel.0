From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Jun 2013 17:41:52 +1000
Subject: linux-next: manual merge of the msm tree with the arm-soc tree
Message-ID: <20130625174152.d776ac051f6f19dfbf876634@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Today's linux-next merge of the msm tree got a conflict in
arch/arm/mach-msm/clock-debug.c between commit ad8c373c9aa3 ("arch: arm:
mach-msm: using strlcpy instead of strncpy") from the arm-soc tree and
commit 8cc7f5338e72 ("ARM: msm: Migrate to common clock framework") from
the msm tree.

The latter removed the file, so I did that, and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/ec526a4c/attachment.sig>
