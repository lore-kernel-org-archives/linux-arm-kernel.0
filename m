From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 15:31:35 -0400
Subject: DT bindings as ABI [was: Do we have people interested in
 device tree janitoring / cleanup?]
In-Reply-To: <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
Message-ID: <20130725193135.GT23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 02:11:31PM -0500, Rob Herring wrote:
> On Thu, Jul 25, 2013 at 11:09 AM, Olof Johansson <olof@lixom.net> wrote:

> > One problem that needs to be solved is obviously how a binding
> > graduates from tentative to locked. This work isn't going to be very
> > interesting to most people, I suspect. Think standards committee type
> > work.
> 
> I think a time based stabilization period would be better than a
> separate directory to apply bindings too. Or time plus periodic review
> perhaps.

The only problem with a time-based versus separate directory is how do
users who've downloaded the tree determine which bindings are stable?
If they pull a tarball, or receive an SDK, there is most likely no git
history attached.

I think the idea of a 'tentative' directory (or 'locked') is churnish,
but necessary.  If I DL'd a tarball and had to type 'tentative' to get
to the binding doc I wanted, that would be a pretty clear clue to be
delicate about how I trust/use/plan with that binding.

thx,

Jason.
