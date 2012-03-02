From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 16:58:11 +0000
Subject: [PATCH 0/4] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
In-Reply-To: <20120302163121.GI11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203012214.07019.arnd@arndb.de>
 <20120302163121.GI11986@titan.lakedaemon.net>
Message-ID: <201203021658.12047.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Jason wrote:
> > 
> > I have other commit IDs for the two patches that I took from your
> > emails, so you should rebase the other patches on top of the
> > version that I have in the arm-soc/kirkwood/board branch, otherwise
> > we end up with duplicate commits my tree when I pull them again.
> 
> Got it, I cherry-picked the series over and incorporated Grant's
> suggestions.
> 

Just making sure you know about this one:

git rebase -i --onto arm-soc/kirkwood/board torvalds/master

The '-i' lets you pick which ones you want to move over, then it
applies all patches from the current branch that are not on
torvalds/master on top of the last commit from arm-soc/kirkwood/board.

If you don't know it yet, I suggest you play with this for an hour
or so that will be very well invested time. If you knew this, then nevermind.

	Arnd
