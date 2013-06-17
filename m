From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Jun 2013 17:01:05 +1000
Subject: linux-next: manual merge of the msm tree with the arm-soc tree
Message-ID: <20130617170105.68c40901e9d43acea18752a7@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Today's linux-next merge of the msm tree got a conflict in
arch/arm/boot/dts/msm8960-cdp.dts between commit e45600107b67 ("Merge tag
'msm-cleanup-for-3.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm into
next/cleanup") from the arm-soc tree and commit 70f0aa52e090 ("Merge
branch 'msm-fix' into for-next") from the msm tree.

I fixed it up (the arm-soc merge used serial at 19440000, the msm merge used
serial at 19c40000, I used the arm-soc version) and can carry the fix as
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/e5c1b8da/attachment.sig>
