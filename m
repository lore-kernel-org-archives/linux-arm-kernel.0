From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 22:29:59 +0000
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100325222959.GI24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 02:52:17PM -0700, Daniel Walker wrote:
> These are all mostly small patches that I've sent out a few times with
> no comments. Let me know if you see any issues.
> 
> The following changes since commit 7ee744f22ffad619e23912a22d1b2795e10ed825:
>   Stephen Rothwell (1):
>         Add linux-next specific files for 20100324

This doesn't seem to be in Linus' tree - ah, no, it's based on linux-next.
So, if I pull this, I get everyone's work into my tree.  To see what
you're actually sending me, do this:

	git diff --stat 9353685..

and it'll show you what you're sending me which isn't in my 'devel' branch
already - and if you replace that git id with the latest Linus' commit in
your tree...

So no thanks.  Will not pull the entire linux-next tree into mine.

Please build your tree on a more stable base, such as Linus' tree.
