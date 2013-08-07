From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 7 Aug 2013 14:25:01 +1000
Subject: linux-next: build failure after merge of the mvebu tree
Message-ID: <20130807142501.79fea47cae17a6a25f1e719e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the mvebu tree, today's linux-next build
(x86_64 allmodconfig) failed like this:

arch/x86/kernel/x86_init.c:115:22: error: 'default_restore_msi_irqs' undeclared here (not in a function)
  .restore_msi_irqs = default_restore_msi_irqs,
                      ^

Caused by commit 8f400e08b197 ("PCI: use weak functions for MSI
arch-specific functions").

I have used the version of the mvebu tree from next-20130806 for today.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/1271e3a5/attachment.sig>
