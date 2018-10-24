From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Oct 2018 14:14:54 +0100
Subject: [Outreachy kernel] Re: [PATCH v2] staging: mt7621-dma: Add
 braces around else branches
In-Reply-To: <alpine.DEB.2.21.1810241404050.2371@hadrien>
References: <20181023211142.GA2661@v> <20181024045653.GA2864@v>
 <af4594cc-05c0-672c-d560-b50705ceaab3@gmail.com>
 <20181024110745.GV30658@n2100.armlinux.org.uk>
 <alpine.DEB.2.21.1810241404050.2371@hadrien>
Message-ID: <20181024131454.GW30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 02:06:18PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 24 Oct 2018, Russell King - ARM Linux wrote:
> 
> > On Wed, Oct 24, 2018 at 12:45:44PM +0200, Matthias Brugger wrote:
> > > Hi Kiberly,
> > >
> > > Thanks for adding all the emails in CC.
> > > I would encourage you for your next patch to distinguish between CC and TO.
> > > You should send your patch TO important maintainers in the get_maintainers.pl
> > > list (as default, to all of them). If there is someone you really want to look
> > > into the patch, then add him/her in TO as well.
> > >
> > > Put the rest (people and mailing lists) in CC. Why? Some people filter their
> > > mails so that they can concentrate on the mails they got send directly and look
> > > on mails they are in CC with lower priority (maybe not at all, because there are
> > > too much?). So it is important to have the maintainers in the TO list and not in CC.
> >
> > +1
> >
> > I'm glad that there's someone else in the Linux community that agrees
> > with me on this point, and is willing to speak out about it.
> 
> If it's an important point, perhaps it should be mentioned in
> submitting-patches.rst?  There is a mention of the Cc tag, but no
> indication of who to put in CC.

submitting-patches.rst talks about the Cc tag in the commit, not the To
or Cc in the email client.

In any case, there's a lot of personal issues here: most kernel
developers don't care whether they're in the To or Cc header of an
email, but there are some who do use it as Matthias says - which is
actually the long-standing definition of these headers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
