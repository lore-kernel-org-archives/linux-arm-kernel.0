From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Aug 2012 18:08:51 +0900
Subject: New Renesas Tree
Message-ID: <20120827090851.GK29274@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am in the process of taking over the maintenance work that Rafael Wysocki
was previously handling through his renesas tree. That is basically the ARM
side of things for Renesas. As such I have created my own renesas tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

The basic structure that I am aiming for is to have topic-branches that
I will request that the arm-soc team pull. And a merge-branch next, which
will be frequently rebased to include all pending topic-branches and
should be included in linux-next.

As things stand I have now sifted through the backlog of patches and I have
either queued up or sent an email query about all patches that I could
find. In either case, if you have an outstanding patch for the renesas tree
and you have not received an email from me about it in the past few days
that means that I have missed it, so please repost.

I will endeavour to get all currently queued patches included in 3.7.
