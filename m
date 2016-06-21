From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 21 Jun 2016 14:58:05 +1000
Subject: linux-next: manual merge of the akpm-current tree with the arm-soc
 tree
Message-ID: <20160621145805.4eac75b6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm/configs/bcm_defconfig

between commit:

  41463c3e6eae ("ARM: Remove bcm_defconfig")

from the arm-soc tree and commit:

  c41079f16bf2 ("lib, switch CONFIG_PRINTK_TIME to int")

from the akpm-current tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
