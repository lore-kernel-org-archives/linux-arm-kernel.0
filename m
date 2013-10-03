From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 3 Oct 2013 09:34:24 -0500
Subject: socfpga-next
In-Reply-To: <20131003141021.GA14042@pengutronix.de>
References: <20131003130240.GS9632@pengutronix.de>
 <1380807118.30559.3.camel@linux-builds1>
 <20131003141021.GA14042@pengutronix.de>
Message-ID: <1380810864.7464.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-03 at 16:10 +0200, Steffen Trumtrar wrote:
> Hi Dinh,
> 
> On Thu, Oct 03, 2013 at 08:31:58AM -0500, Dinh Nguyen wrote:
> > Hi Robert,
> > 
> > On Thu, 2013-10-03 at 15:02 +0200, Robert Schwebel wrote:
> > > Hi Dinh,
> > > 
> > > On Wed, Oct 02, 2013 at 09:35:29AM +0200, Steffen Trumtrar wrote:
> > > > BTW: It seems there is no official maintainer(tree) for the socfpga dt stuff.
> > > > So, I rebased onto next-20130927.
> > > 
> > > It would be great if you could establish some kind of socfpga-next tree,
> > > where we can see what you have already taken, and which could be put
> > > into linux-next.
> > > 
> > > What do you think?
> > 
> > Do you mean at kernel.org or just at any other place? I have a git repo
> > that I'm managing with commits that are sent out for review or have
> > Acks.
> > 
> > git://git.rocketboards.org/linux-socfpga-next.git
> > 
> > next-dt : DTS updates
> 
> It seems I overlooked this branch, last time I checked your repo...
> 
> > for-next : latest from Linus + patches(being reviewed)
> > 
> 
> ...this was the only one I have seen.
> Do you also collect the DTS(I) patches? If so, you should add that to the
> MAINTAINERS file. I think, it might be a good idea to collect that stuff
> in one place, because *.dts files really love to produce merge conflicts.
> No need to bother the ARM or OF maintainers with that.

Yes, I will be collecting DTS patches. I will add the git repo link to
the MAINTAINERS file.

Dinh
> 
> Regards,
> Steffen
> 
