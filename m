From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 10:42:52 -0800
Subject: [GIT PULL 4/4] mach-virt platform code for 3.9
In-Reply-To: <20130211174731.GO9801@mudshark.cambridge.arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-4-git-send-email-will.deacon@arm.com>
 <20130211172747.GA23212@quad.lixom.net>
 <20130211174731.GO9801@mudshark.cambridge.arm.com>
Message-ID: <20130211184252.GA30668@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 05:47:31PM +0000, Will Deacon wrote:
> On Mon, Feb 11, 2013 at 05:27:47PM +0000, Olof Johansson wrote:
> > On Mon, Feb 04, 2013 at 01:55:31PM +0000, Will Deacon wrote:
> > > NOTE: I'm not suggesting you pull this one as it stands -- see below!
> > > 
> > > This is the last batch from me (Marc is dealing with vgic and virtual
> > > timers) and introduces support for mach-virt. This depends on:
> > > 
> > > 	- for-arm-soc/arch-timers (third pull request in this series)
> > > 	- for-rmk/virt/psci (already pulled)
> > > 	- irqchip/gic-vic-move (an arm-soc branch)
> > > 
> > > As a result, the diffstat is atrocious so it would be better if you
> > > could create a branch merging the above dependendies, which I could
> > > rebase onto (there's actually only two patches here).
> > 
> > So, while the diffstats below look pretty bad, the actual new code is small and
> > easy to get an overview when I pull them in.
> > 
> > I've staged this in a separate branch (next/virt), that pulls in all the
> > dependencies first, then 3/4 and 4/4. It merges cleanly into our for-next as
> > well, so this is looking great. It needs a fixup for sys_timer setup before I
> > actually push it out merged though, so please send a patch over.
> 
> Great, thanks Olof. I've included a small patch to fix the sys_timer stuff
> below.

Thanks, applied and I have now merged mach/virt into for-next.


-Olof
