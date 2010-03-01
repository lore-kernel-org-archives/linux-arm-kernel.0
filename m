From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 28 Feb 2010 19:42:25 -0500 (EST)
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100228161449.GD16745@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1002281928200.10679@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Feb 2010, Russell King - ARM Linux wrote:

> You've destroyed your original commits, so this calls into question my
> entire 'devel-stable' branch.
> 
> I've still not decided what to do about this.  I'll ask Linus to merge
> most of the 'devel' stuff without 'devel-stable' merged into mainline
> to move stuff forward - this means _no_ _one's_ git work will be merged
> through my tree, at least initially.
> 
> However, I'm putting 'devel-stable' on hold; I'll let the other ARM git
> maintainers discuss this and work out what they're going to do about
> this mess.  One solution is to destroy the 'devel-stable' branch in
> its entirety, and get everyone to resend all their pull requests.
> That's *not* nice.

What about simply ignoring Eric's latest pull request and have your 
'devel-stable' be merged by Linus as is?  Surely the earlier branch you 
merged from Eric wasn't that bad anyway, and Eric can certainly provide 
new commits on top later on to fix possible issues with that in order to 
bring his stuff to the same state as what he just asked you to pull.


Nicolas
