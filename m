From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Jul 2014 11:54:09 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140717115409.03b7fb40@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/Kconfig between commit 2fd48f94426d ("ARM: mach-s5p: get rid
of all <mach/gpio.h> headers") from the arm-soc tree and commit
72dc5e8f84b0 ("ARM: S5PV210: Enable multi-platform build support") from
the samsung tree.

I fixed it up (the latter is a superset of the former) and can carry
the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/b629ebef/attachment.sig>
