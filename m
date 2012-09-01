From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Sep 2012 19:22:07 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120901163235.GB748@mannheim-rule.local>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
 <20120830172304.GA18957@n2100.arm.linux.org.uk>
 <20120830183711.GY19437@titan.lakedaemon.net>
 <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
 <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
 <20120901152544.GB24085@n2100.arm.linux.org.uk>
 <20120901163235.GB748@mannheim-rule.local>
Message-ID: <20120901182207.GC24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 09:32:35AM -0700, Jonathan Nieder wrote:
> Hi Russell,
> 
> Russell King - ARM Linux wrote:
> > On Sat, Sep 01, 2012 at 03:20:16PM +0100, Ben Hutchings wrote:
> >> On Fri, 2012-08-31 at 23:32 +0100, Russell King - ARM Linux wrote:
> 
> >>> No it is not.  It seems you also need to read
> >>> Documentation/stable_kernel_rules.txt
> >> [...]
> >>
> >> None of which contradicts what I said above.  There is no need for
> >
> > I really can't believe you just said that.  You have not read the document.
> 
> Ben makes use of that document on a daily basis to maintain the 3.2.y
> tree, so I suspect he has read it.  More importantly, as maintainer of
> a stable branch, I suspect he is familiar with the de facto rules.
> 
> Is there some specific misleading wording in the document?  Pointing
> it out, perhaps with a suggested replacement, could lead to the text
> being fixed, which would be a nice outcome that could make up for the
> pointlessly inflammatory discussion.

I have pointed out the wording in my reply previous to the one above.
The wording in the document is quite clear and unambiguous, and differs
from Ben's statement.

If Ben wishes to be more lenient than the document for the trees that
he's looking after, then that is his perogative, but that doesn't mean
that the stable rules applicable for general submission are any different
from the documentation.

Maybe Greg is not so lenient - so proposing new wording would be a foolish
(and arrogant) act.  It is for the stable team - and only the stable team
as a whole - to decide whether the published rules are wrong and need
modification. Until they do, the documented submission rules are The Rules
and not some comments from anyone else (including individual stable
maintainers.)

I hope that the stable maintainers are discussing the issue amongst
themselves now, and if necessary we'll see a patch to the documentation
so that it reflects the proper position.  Until that happens though, Ben's
comments do not mean anything as far as general stable submission policy
goes.
