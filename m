From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jan 2014 20:59:18 -0800
Subject: [GIT PULL 00/21] Third Round of Renesas ARM Based SoC DT Updates
 for v3.14
In-Reply-To: <20140103234238.GA5150@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
 <20140102184939.GE8684@quad.lixom.net>
 <20140103234238.GA5150@verge.net.au>
Message-ID: <20140104045918.GA3643@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 04, 2014 at 08:42:38AM +0900, Simon Horman wrote:
> On Thu, Jan 02, 2014 at 10:49:39AM -0800, Olof Johansson wrote:
> > On Tue, Dec 24, 2013 at 11:19:23PM +0900, Simon Horman wrote:
> > > Hi Kevin, Hi Olof, Hi Arnd,
> > > 
> > > please consider this third round of Renesas ARM based SoC DT updates for v3.14.
> > > 
> > > This is based on a merge of:
> > > 
> > > * The second round of Renesas ARM based SoC DT updates for v3.14,
> > >   tagged as renesas-dt2-for-v3.14, which I have previously sent a
> > >   pull-request for.
> > > 
> > > * The second round of Renesas ARM based SoC updates for v3.14,
> > >   tagged as renesas-soc2-for-v3.14, which I have previously sent a
> > >   pull-request for.
> > > 
> > > * The clk-next-shmobile branch of Mike Turquette's tree
> 
> git://git.linaro.org/people/mike.turquette/linux.git clk-next-shmobile
> 
> > > 
> > > * The clockevents/for-Simon-3.13-rc2 branch of Daniel Lezcano's tree
> 
> git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/for-Simon-3.13-rc2
> 
> > > * The pinctl/for-next branch of Linus Walleij's tree
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git pinctl/for-next
> 
> > > 
> > > * v3.13-rc3
> > 
> > Ah, here's the missing clk branch that caused earlier merges not to build.
> 
> Yes, sorry about that.
> 
> > Please provide actual URLs for the external branches since we want to
> > track them. I can't reverse-engineer them since you use remotes instead
> > of the URL when you merged in, unfortunately.
> > 
> > (No need to redo the pull request, just give me the URLs, please.
> 
> Sorry about that. Is the information I have added above sufficient?

Yep, thanks! Since the branches both come from parties that we normally
share branches with. I've cc:d them on this reply as well.

The only branch that isn't optimal is that it pulls in all of for-next from the
pinctrl tree, but it's OK for that tree in general. Having a dedicated topic
branch makes it a little harder to forget and accidentally rebase.

Note that it's pretty much ideal for us to be cc:d into the three-way handshake
that the remote branch will be guaranteed to be stable. The last thing we want
is that some of these people didn't quite understand what we need w.r.t.
stability (that has happened in the past). Especially if they feed their
branches up to another maintainer above them.

I'll merge in the dt3 branch with the above three as external dependency
branches.


-Olof
