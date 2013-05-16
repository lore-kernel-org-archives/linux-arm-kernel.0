From: horms@verge.net.au (Simon Horman)
Date: Thu, 16 May 2013 14:04:53 +0900
Subject: linux-next: manual merge of the renesas tree with Linus' tree
In-Reply-To: <20130516132253.8865ca7b6503bd6fe9e6b05a@canb.auug.org.au>
References: <20130516132253.8865ca7b6503bd6fe9e6b05a@canb.auug.org.au>
Message-ID: <20130516050450.GA13842@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 01:22:53PM +1000, Stephen Rothwell wrote:
> Hi Simon,
> 
> Today's linux-next merge of the renesas tree got a conflict in
> arch/arm/mach-shmobile/board-lager.c between commit 65be2de17aae ("ARM:
> shmobile: use r8a7790 timer setup code on Lager") from Linus' tree and
> commit 993340a1390d ("ARM: shmobile: use r8a7790 timer setup code on
> Lager") from the renesas tree.
> 
> These are the same patch but different commits :-( and there are further
> commits touching this file in the renesas tree.  Please clean up your
> tree and remove anything that has already gone upstream as different
> patches.  I used the renesas tree version of this file.


Sorry about that. I am working on re-basing my branches on
top of v3.10-rc1 and I have confirmed that in my current local
branches the problem you describe is no longer present.
I plan to push the refreshed branches, including a new next branch
for linux-next, once a few bug-fix patches have been reviewed.
