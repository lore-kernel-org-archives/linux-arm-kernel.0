From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Sep 2012 21:11:05 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120901183859.GA958@mannheim-rule.local>
References: <20120830172304.GA18957@n2100.arm.linux.org.uk>
 <20120830183711.GY19437@titan.lakedaemon.net>
 <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
 <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
 <20120901152544.GB24085@n2100.arm.linux.org.uk>
 <20120901163235.GB748@mannheim-rule.local>
 <20120901182207.GC24085@n2100.arm.linux.org.uk>
 <20120901183859.GA958@mannheim-rule.local>
Message-ID: <20120901201105.GD24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 11:38:59AM -0700, Jonathan Nieder wrote:
> Hi Russell,
> 
> Russell King wrote:
> 
> > I have pointed out the wording in my reply previous to the one above.
> > The wording in the document is quite clear and unambiguous, and differs
> > from Ben's statement.
> 
> Ah, ok.
> 
> Meh.  I guess we disagree about what the wording means.  I think it's
> already clear.

Okay, if you think it's clear, then you tell me where in this text,
which is a direct quote from the stable_kernel_rules.txt document:

| Procedure for submitting patches to the -stable tree:
| 
|  - Send the patch, after verifying that it follows the above rules, to
|    stable at vger.kernel.org.  You must note the upstream commit ID in the
|    changelog of your submission, as well as the kernel version you wish
|    it to be applied to.
|  - To have the patch automatically included in the stable tree, add the tag
|      Cc: stable at vger.kernel.org
|    in the sign-off area. Once the patch is merged it will be applied to
|    the stable tree without anything else needing to be done by the author
|    or subsystem maintainer.

it gives you permission to send a patch to the stable team email address
_without_ the commit ID.  Note carefully the sentence which starts "You
must ...".  "Must" is a very strong word, and doesn't give you any scope
for "not doing the action".

The rest of the points below that describe other items that may be
required, but the above are the only two which refer to _how_ patches
are _sent_ to the stable team.

> Here's what Greg wrote the last time he was asked:
> http://article.gmane.org/gmane.comp.version-control.git/178986

In which case, why did Greg reply with his standard form email telling
Jason to read the stable_kernel_rules.txt document when Jason added the
Cc to his email?

It is as clear as mud now when stable at vger.kernel.org should be Cc'd and
when it should not.  On one hand Greg has said (in the URL you quote above)
that he'd like discussion about stable patches to be copied to the stable
team address.  On the other hand, he replies with his standard form letter
telling people not to do so when they do copy that address.

I'm now totally confused.  Clearly the document which Greg keeps pointing
to is out of date.

What _are_ the real situations when emails should be sent to the stable
team?  Can we have a definitive answer from Greg et.al - and can we have
the documentation updated please ?
