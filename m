From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 25 Mar 2010 15:32:58 -0700
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <20100325222959.GI24984@n2100.arm.linux.org.uk>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<20100325222959.GI24984@n2100.arm.linux.org.uk>
Message-ID: <1269556378.21793.47.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-25 at 22:29 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 02:52:17PM -0700, Daniel Walker wrote:
> > These are all mostly small patches that I've sent out a few times with
> > no comments. Let me know if you see any issues.
> > 
> > The following changes since commit 7ee744f22ffad619e23912a22d1b2795e10ed825:
> >   Stephen Rothwell (1):
> >         Add linux-next specific files for 20100324
> 
> This doesn't seem to be in Linus' tree - ah, no, it's based on linux-next.
> So, if I pull this, I get everyone's work into my tree.  To see what
> you're actually sending me, do this:
> 
> 	git diff --stat 9353685..
> 
> and it'll show you what you're sending me which isn't in my 'devel' branch
> already - and if you replace that git id with the latest Linus' commit in
> your tree...
> 
> So no thanks.  Will not pull the entire linux-next tree into mine.

Oh please why not! (just joking) ..

> Please build your tree on a more stable base, such as Linus' tree.

I thought you wanted stuff on your development tree? Where can I get
that other than in next? It's easy enough to put it on a linus tree if
that's acceptable.

Daniel
