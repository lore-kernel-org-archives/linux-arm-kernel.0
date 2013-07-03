From: w@1wt.eu (Willy Tarreau)
Date: Thu, 4 Jul 2013 00:38:58 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703223323.GA21722@localhost>
References: <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate> <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org> <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130702232311.GA3949@localhost> <20130703043330.GF10215@1wt.eu>
 <20130703223323.GA21722@localhost>
Message-ID: <20130703223858.GL16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Wed, Jul 03, 2013 at 07:33:24PM -0300, Ezequiel Garcia wrote:
> Hi everyone,
> 
> On Wed, Jul 03, 2013 at 06:33:30AM +0200, Willy Tarreau wrote:
> > 
> > On Tue, Jul 02, 2013 at 08:23:12PM -0300, Ezequiel Garcia wrote:
> > > > Yes and indeed I must say that when I read the driver I found some
> > > > similarities with pxa3xx, though it was done differently. I initially
> > > > wanted to try to merge them but of course without the spec it's a huge
> > > > waste of time, especially considering that this is still in the roadmap
> > > > of the Free Electrons guys even though low priority.
> > > 
> > > I wish I could say I'm going to work on this soon but, as Thomas said,
> > > we have no idea when/if NAND will be prioritized.
> > > 
> > > On the other side if you look at the driver Willy just posted, merging
> > > the juicy stuff into pxa3xx-nand driver is not for the faint of heart.
> > > 
> > > Without the spec, is only tougher.
> > 
> > Confirmed :-)
> > 
> 
> Just a note on the (lack of) documentation issue.
> 
> If there's a brave soul reading this and longing to tackle this,
> the pxa3xx SoC documentation *is* publicly available:
> 
> http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
>
> The NAND specifications can be found in the "[...] Vol. II: Memory Controller" document,
> inside the above zip file. IMHO, that's the reading entry point in order to
> understand pxa3xx-nand driver better.

Yes I have this one as well, but initially since I was not really sure
about the ressemblance of the two controllers, I did not spend too much
time on it. Now probably it can be useful, especially if we use your
existing work as a complement of information :-)

Best regards,
Willy
