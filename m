From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 19 Apr 2013 16:46:36 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20130419164636.0d2405ca5fd927f1ba31fe40@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (powerpc ppc64_defconfig)
failed like this:

powerpc64-linux-ld: cannot find drivers/pci/host/built-in.o: No such file or directory

Caused by commit 9ecbe03ae85b ("pci: infrastructure to add drivers in
drivers/pci/host").

I have used the arm-soc tree from next-20130418 for today.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130419/02269d24/attachment-0001.sig>
