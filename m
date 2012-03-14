From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 10:59:01 +1100
Subject: linux-next: build failure after merge of the final tree (arm-soc
 tree related)
Message-ID: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the final tree, today's linux-next build (powerpc
allmodconfig) failed like this:

drivers/ata/sata_mv.c:4185:1: error: '__mod_of_device_table' aliased to undefined symbol 'mvsdio_dt_ids'

Caused by commit f1e1e148c5cb ("ARM: kirkwood: sata_mv: add device tree
binding").
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/df18df76/attachment.sig>
