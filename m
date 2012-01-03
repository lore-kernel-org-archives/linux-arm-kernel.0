From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 4 Jan 2012 10:47:58 +1100
Subject: linux-next: interesting merges in the arm-soc tree
Message-ID: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I noticed that the arm-soc tree has merged in the v4l-dvb and the
slave-dma trees today.   Is there some good reason for this?  It fixes a
few conflicts (but that is not excuse) and there may be dependencies in a
driver on the v4l-dvb tree (but maybe that means that that driver should
be merged via the v4l-dvb tree - it looks like the "at91/drivers" is
based on the v4l-dvb tree, so probably doesn't depend on anything else on
the arm-soc tree).

If nothing else, are you sure that neither of those merged trees will
rebase?  You have also just inherited any bugs in those two trees.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120104/e1afe1e9/attachment-0001.sig>
