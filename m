From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 17:07:53 +0000
Subject: [PATCH] ep93xx: fix build error in edb93xx framebuffer support
In-Reply-To: <0D753D10438DA54287A00B027084269764CF0C44E3@AUSP01VMBX24.collaborationhost.net>
References: <201102021738.22717.hartleys@visionengravers.com>
	<0D753D10438DA54287A00B027084269764CF0C44E3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110204170753.GA8732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 11:03:12AM -0600, H Hartley Sweeten wrote:
> Russell,
> 
> The patch below is needed to fix a build error introduced by:
> 
> ARM: 6643/1: ep93xx: add framebuffer support to edb93xx boards
> 
> This patch is in linux-next now (commit 6491e80bbb830a593649be9fce83c6b2a520e8d7)
> but has not reached Linus tree.
> 
> Should I add it to your patch tracking system?

It's probably just as easy to roll it into the existing patch.
I'll do that in a bit.
