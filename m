From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 10:53:18 +0100
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.15 (incr. pull #2)
In-Reply-To: <20140301041947.GR1872@titan.lakedaemon.net>
References: <20140301041947.GR1872@titan.lakedaemon.net>
Message-ID: <201403171053.18567.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 March 2014, Jason Cooper wrote:
> All,
> 
> This is a big one for us :)  You've already pulled part of this as
> mvebu/soc-3xx.  I merged that branch and mvebu/soc-kw back into
> mvebu/soc.  This whole lot has been in -next all week.  Two minor issues
> were discovered and patches added to correct them.
> 
> At this point I think the kirkwood and armada changes have been shaken
> out enough that they no longer need their own branches.  If you don't
> agree, just let me know and I'll send separate pull requests for the
> per-SoC branches.
> 
> This is an incremental pull request from tags/mvebu-soc-3.15 in the
> mvebu/soc branch up to tags/mvebu-soc-3.15-2.
> 
> There will be a small conflict between this branch and mvebu/dt.  This
> is due to the kirkwood migration and maintaining bisectability.  I'll
> detail the conflict in the mvebu/dt pull request.
> 
> Please pull.
> 

Pulled into next/soc, sorry for the delay.

I noticed that the shortlog in the pull request listed the parts
from mvebu/soc-3xx again, which confused me a bit because they
didn't show up in the merge, but I checked that it's all good.

	Arnd
