From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 26 Feb 2014 15:01:59 +1100
Subject: linux-next: manual merge of the crypto tree with the arm-soc tree
Message-ID: <20140226150159.7ea5e60285ee9d0193bde811@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

Today's linux-next merge of the crypto tree got a conflict in
drivers/char/hw_random/Kconfig between commit 2257ffbca73c ("hwrng: msm:
switch Kconfig to ARCH_QCOM depends") from the arm-soc tree and commit
f9bee046c915 ("hwrng: msm: switch Kconfig to ARCH_QCOM depends") from the
crypto tree.

Two version of the same patch ... I just kept the arm-soc version.

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/6b2714ce/attachment.sig>
