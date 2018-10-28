From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 29 Oct 2018 10:08:31 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20181029100831.73b12672@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  drivers/soc/qcom/Kconfig

between commit:

  a978a5b8d83f ("net/kconfig: Make QCOM_QMI_HELPERS available when COMPILE_TEST")

from Linus' tree and commit:

  ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")

from the arm-soc tree.

I fixed it up (I just used the version in Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/fd484807/attachment.sig>
