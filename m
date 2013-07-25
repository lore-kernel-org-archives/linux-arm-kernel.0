From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 16:08:13 -0400
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130725200435.GW9858@sirena.org.uk>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <20130725200435.GW9858@sirena.org.uk>
Message-ID: <20130725200813.GV23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 09:04:35PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2013 at 03:31:35PM -0400, Jason Cooper wrote:
> 
> > I think the idea of a 'tentative' directory (or 'locked') is churnish,
> > but necessary.  If I DL'd a tarball and had to type 'tentative' to get
> > to the binding doc I wanted, that would be a pretty clear clue to be
> > delicate about how I trust/use/plan with that binding.
> 
> Another option for this is to annotate within the document itself.

True, and this would make it easier to mark reg, interrupts, etc as
stable, and eg 'ti,hwmods' as unstable.  However, it could get pretty
messy.  Perhaps moving to a schema would help with that.

thx,

Jason.
