From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 08:52:21 -0500
Subject: [PATCH v5 0/3] Introduce atomic MMIO register modify
In-Reply-To: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212135221.GL10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:41:34AM -0300, Ezequiel Garcia wrote:
> After this patchset stalled for several months, I'm picking where
> we left. The last conclusion [1] was that instead of doing the arch-generic
> from scratch, we'd start by implementing the API in ARM only.
> 
> In other words, this is basically a resend of v3, with some of the typos fixed
> and using raw spinlocks.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg271773.html
...
> If nobody has objections, I'll add patch 1/3 to ARM's tracking system
> as usual.

It looks like everyone's ok with that.  We can submit the drivers for
v3.15 unless Russell's willing to set up a topic branch for patches 2
and 3 to depend upon.

thx,

Jason.
