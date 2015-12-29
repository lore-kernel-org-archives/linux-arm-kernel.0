From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Dec 2015 21:01:18 -0800
Subject: [GIT PULL] BCM2835/6 changes for 4.5 (I hope)
Message-ID: <1451365282-10505-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently this is really late in the process (sorry!  I still haven't
figured out the timelines.), but I'm hoping we could merge these
changes for 4.5.  This includes the Raspberry Pi 2 port, with just two
minor fixes from the last submission.

The reason I've been pushing hard to get pi2 in is:

1) It's a lot of conflict resolution every version since it requires
splitting the 2835 DT file.

2) People are generally using pi2 these days, so it means people are
more likely to upstream 2835 driver code if we have an upstream port
they can run.

Testing status: kbuild test robot builds passed.  Boot tested each
branch head on pi1.  Boot tested the merge of all 4 branches on pi1.
Boot tested the merge of all 4 branches on pi2, with and without the
irqchip fixes.
