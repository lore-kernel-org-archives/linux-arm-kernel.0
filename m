From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 May 2014 19:46:38 -0400
Subject: [PATCH RFC 02/11] sound: ASoC: kirkwood: Remove unused drivers
In-Reply-To: <20140527195212.GE12304@sirena.org.uk>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-5-git-send-email-andrew@lunn.ch>
 <20140526155901.GF22111@sirena.org.uk>
 <20140527164530.GJ26379@lunn.ch>
 <20140527180047.GA12304@sirena.org.uk>
 <20140527181818.GK26379@lunn.ch>
 <20140527195212.GE12304@sirena.org.uk>
Message-ID: <20140527234638.GV8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 08:52:12PM +0100, Mark Brown wrote:
> On Tue, May 27, 2014 at 08:18:18PM +0200, Andrew Lunn wrote:
> > On Tue, May 27, 2014 at 07:00:47PM +0100, Mark Brown wrote:
> > > On Tue, May 27, 2014 at 06:45:30PM +0200, Andrew Lunn wrote:
> 
> > > > This is an RFC patch, as it says in the Subject line, and the cover
> > > > note. It is not intended to be applied yet. Please unapply it, and the
> > > > other one in the series you have applied.
> 
> > > Eh?  I thought the discussion was that everything was OK and we were
> > > going to go ahead with this approach.  Or to put it another way what's
> > > wrong with this and what's expected to change?
> 
> > What is wrong is that the merge path for the first patch, which
> > removes the boards making use of these drivers, has already closed for
> > patches.  So we now have boards left in the tree with broken audio. We
> > can leave it that way, because these boards are actually in the tree
> > twice. One using DT, which will work as things are now, and old style
> > board file boards which are broken.
> 
> OK, so another part of this is that you didn't send the first patch to
> me so I didn't realise that the boards were still there.  TBH I'd have
> expected that removal to just be going in independently of cleaning up
> the drivers.
> 
> Anyway, I dropped the patches.

Thanks Mark, sorry for the confusion.

thx,

Jason.
