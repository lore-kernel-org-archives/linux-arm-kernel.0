From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 13:59:40 +0000
Subject: [GIT PULL V2 1/4] ARM: Kirkwood: DT bindings for v3.7
In-Reply-To: <20120918172426.GL5469@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120913053045.GB24290@quad.lixom.net>
 <20120918172426.GL5469@titan.lakedaemon.net>
Message-ID: <201209191359.40856.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Jason Cooper wrote:
> Ok, I'm still mastering the art of branch dependencies.  The acceptance
> of Gregory's cache-l2x0 series is holding up everything else.
> Rightfully so, rmk has some issues with it.
> 
> However, in my pullrqs and in my branch merging I treated it as a
> dependency for everything that came after it (pr 1,2,3,4).  I'd like to
> undo that now to get things moving.  The dependency was not strictly
> necessary, I was simply trying to achieve an ordering of branches.
> 
> The only way I know to do this is to redo my branches and republish.
> Basically, I would remove Gregory's patches and the dependency on 'arm:
> cache-l2x0' from pullrq [1/4] Kirkwood DT bindings.

Right, makes sense.

> Obviously, this would break things for folks tracking my branches.
> Hopefully anyone crazy enough to track my branches is competent enough
> rebase onto the new branches.  Even still, I don't want to mess anyone up.
> 
> I think the benefits of getting these patches in for this merge window
> outweigh a onetime breaking of my branches.  Is there anything I'm not
> considering before I do this?
>
> I'll do the work now, but hold off on pushing or sending new pullrq's
> for a day or two or until I hear from you guys.

My rule is normally that I treat any branches coming from subarchitecture
maintainers as unstable until they are merged into arm-soc.
If you haven't promised anyone to keep your branches stable, I see no
problem with rebasing them to avoid the dependency.

	Arnd
