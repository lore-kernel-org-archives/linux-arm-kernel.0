From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 19:47:27 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120313194727.9d5939c174d54ea1569403f5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-versatile/localtimer.c between commit e9f07fbc5f5b ("ARM:
plat-versatile: convert to twd_local_timer_register() interface") from
the arm tree and commit e129440af638 ("ARM: versatile: Map local timers
using Device Tree when possible") from the arm-soc tree.

I did the obvious thing and removed the file (as the former does), but
there is probably more to be fixed up.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/6a619335/attachment.sig>
