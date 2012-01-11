From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 11 Jan 2012 13:31:46 +1100
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
Message-ID: <20120111133146.990e2b7115c9fa80e8fc3234@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got conflicts in a large
number of files between commits from the arm-soc tree and commits from the
v4l-dvb tree.  You have rebased the v4l-dvb tree onto v3.2 while the
arm-soc tree had merged a previous version. you have then added a lot
more commits on top of the result - which produces all the conflicts.  :-(

This is exactly the sort of pain I alluded to when I first noted that the
v4l-dvb tree had been merged into the arm-soc tree ...

Not happy.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120111/3b0aa678/attachment.sig>
