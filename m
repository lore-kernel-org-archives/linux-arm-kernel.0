From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2011 14:55:53 +0200
Subject: Please submit platform trees for inclusion in arm-soc.git v3.1
In-Reply-To: <alpine.LFD.2.00.1107111815340.14596@xanadu.home>
References: <201107012018.14619.arnd@arndb.de>
	<201107112337.08892.arnd@arndb.de>
	<alpine.LFD.2.00.1107111815340.14596@xanadu.home>
Message-ID: <201107121455.53717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Nicolas Pitre wrote:
> On Mon, 11 Jul 2011, Arnd Bergmann wrote:
> 
> > On Friday 08 July 2011, Kevin Hilman wrote:
> > > > Time is running out for the current cycle, so any changes that you
> > > > want to see merged in linux-3.1 through the arm-soc tree should be
> > > > submitted in form of pull-requests very soon.
> > > 
> > > [...]
> > > 
> > > It looks like your "remove rmk/for-next" commit may not have been
> > > totally complete.
> > > 
> > > Trying to merge your master branch and Russell's current for-next branch
> > > still results in conflicts in files that should only be touched in
> > > Russell's branch (specifically, these seem related to changes in
> > > Russell's 'suspend' branch that is included in his 'for-next' branch.)
> > 
> > Yes, that's my fault for not fixing this up correctly after initially
> > doing the incorrect pull.
> > 
> > I guess I'll throw away the current master branch and generate a new
> > one. After discussing this with Russell, I think it's best to treat
> > the master branch as temporary anyway unless Nicolas or Thomas come up
> > with a good reason against doing this.
> 
> No objections.  However, to avoid confusion, I'd suggest getting rid of 
> the branch called "master" entirely and call it something else.

Yes, makes sense.

I'll call it 'for-next' then, following the same scheme that Russell uses.
Hopefully people will take it as a hint that it's getting rebased.

	Arnd
