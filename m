From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Dec 2012 13:20:14 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20121221132014.0bf8772fb3e48c51cec1548a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
drivers/pinctrl/pinctrl-exynos5440.c and
drivers/pinctrl/pinctrl-samsung.c between commit e5b4c9d4ab55 ("pinctrl:
exynos5440: Fix compile error in pinctrl-exynos5440/samsung.c") from the
pinctrl tree and commit d5fd5da290ce ("pinctrl: exynos5440/samsung:
Staticize pcfgs") from the arm-soc tree.

The former is a superset of the latter, so I used that (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121221/deffb86d/attachment.sig>
