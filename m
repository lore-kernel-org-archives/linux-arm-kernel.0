From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 21 Dec 2011 12:20:46 +1100
Subject: linux-next: manual merge of the slave-dma tree with the arm-soc tree
Message-ID: <20111221122046.e6b8f4a9eb06015cb4f89d36@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Today's linux-next merge of the slave-dma tree got a conflict in
drivers/dma/Kconfig between commit eb444fee9289 ("dma: MX3_IPU fix
depends") from the arm-soc tree and commit 8e2d41f8c856 ("dma i.MX:
remove individual SOC dependency") from the slave-dma tree.

The latter seems to be a superset of the former, so I used that
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111221/918ed355/attachment.sig>
