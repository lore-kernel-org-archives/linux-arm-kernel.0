From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2011 22:00:29 +0000
Subject: [GIT PULL] ARM irqchip consolidation
In-Reply-To: <4EC54DBB.9090309@arm.com>
References: <4EC39D44.8000706@arm.com>
 <20111117172319.GX9581@n2100.arm.linux.org.uk> <4EC54DBB.9090309@arm.com>
Message-ID: <20111121220029.GT9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 06:08:59PM +0000, Marc Zyngier wrote:
> If you have a stable branch on which I can rebase, I'm happy to do it
> (I've just resolved these conflicts on -next). If it's more convenient
> to do it later in the cycle, I can wait. Just let me know what is the
> most convenient route for you.

I've now merged the restart changes into the 'devel' branch, and then
followed on with your changes on top of that - fixing the conflicts
along the way.

I decided not to push it out in the devel-stable branch until you've
had a chance to verify that the conflict resolution is correct - I've
added some limited explanations in the merge commit for the two things
which weren't a trivial resolution.  Once you've confirmed it's fine,
I'll push the stuff over to the devel-stable branch.

The devel branch also has nico's vmalloc stuff in too, and the whole
lot should end up in linux-next later this week (maybe even tomorrow
if sfr hasn't already picked up my tree.)
