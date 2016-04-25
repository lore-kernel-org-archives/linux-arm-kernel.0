From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 26 Apr 2016 09:43:31 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20160426094331.64032731@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "of_flash_probe_versatile" [drivers/mtd/maps/physmap_of.ko] undefined!

Caused by commit

  b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")

I used the arm-soc tree from next-20160422 for today.

-- 
Cheers,
Stephen Rothwell
