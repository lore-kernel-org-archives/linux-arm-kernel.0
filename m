From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2011 15:56:58 +0200
Subject: Merging Cadence macb/gem patches
In-Reply-To: <20110913125610.GE2781@pulham.picochip.com>
References: <20110830103655.GE5414@pulham.picochip.com>
	<20110913125610.GE2781@pulham.picochip.com>
Message-ID: <201109131556.59492.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011, Jamie Iles wrote:
> On Tue, Aug 30, 2011 at 11:36:55AM +0100, Jamie Iles wrote:
> > Hi Arnd,
> > 
> > I have a series of patches[1] to add support for the Cadence GEM 
> > Ethernet MAC to the macb driver.  A while back, DaveM said that he would 
> > be happy for these to go through an ARM tree[2], so would you pull these 
> > into the arm-soc tree?
> > 
> > At the moment my patches are based on 3.1-rc1, but since then the 
> > drivers have been moved about and git merge doesn't seem to resolve 
> > this, so should I base them on the commit that moved them from the 
> > netdev tree?  I'm not sure how to handle this.
> 
> Would you be able to take these if I send you a pull request please?

Hi Jamie,

Sorry for not replying earlier on this. I first tried merging them
when you sent the mail, but couldn't figure out a good way, especially
with git.kernel.org being down, I can't see how the merge with the
netdev tree would go (it would probably fail miserably because of the
file move).

DaveM, do you have a copy of the netdev tree available somewhere else,
so I can take these patches into a branch that I push after yours is
in? If not, I think it would be better to take the driver into your
tree instead, including the ARM specific changes.

	Arnd
