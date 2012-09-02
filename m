From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 02 Sep 2012 18:26:21 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120902170434.GA31141@n2100.arm.linux.org.uk>
References: <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
 <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
 <20120901152544.GB24085@n2100.arm.linux.org.uk>
 <20120901163235.GB748@mannheim-rule.local>
 <20120901182207.GC24085@n2100.arm.linux.org.uk>
 <20120901183859.GA958@mannheim-rule.local>
 <20120901201105.GD24085@n2100.arm.linux.org.uk>
 <1346594067.4958.7.camel@deadeye.wl.decadent.org.uk>
 <20120902170434.GA31141@n2100.arm.linux.org.uk>
Message-ID: <1346606781.7787.25.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-09-02 at 18:04 +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 02, 2012 at 02:54:27PM +0100, Ben Hutchings wrote:
> > On Sat, 2012-09-01 at 21:11 +0100, Russell King - ARM Linux wrote:
> > [...]
> > > It is as clear as mud now when stable at vger.kernel.org should be Cc'd and
> > > when it should not.
> > [...]
> > 
> > Perhaps what you're missing is that it's an open mailing list (as was
> > stable at kernel.org), not an alias for 'the stable team'.  As with any
> > other kernel mailing list, you don't need to get explicit permission to
> > send mail to it.  So there is no 'should not'.
> 
> Then please explain why people keep getting Greg's standard form "this
> is not how you submit patches for stable" when they CC a _discussion_
> to the address.

When someone sends a patch that they want to be applied in mainline and
then later in stable updates, they must include the cc: line in the
commit message.  Actually cc'ing to the stable list is optional.

When someone sends a preliminary version of a patch for discussion, and
that might, after proper submission, be wanted in stable updates, that
line is not necessary.  The patch should however have '[RFC]' in the
subject, so everyone understands that this is not a request for the
patch to be applied.  This should not result in a form response.

I don't think this distinction between patch-to-be-applied and
patch-to-be-discussed is anything peculiar to the stable list.

[...]
> As I have pointed out many times in this thread, there is inconsistency
> between what you are saying, what Greg has said, what the documentation
> says, and the reaction that people get from Greg when they do send to
> that address.  Something needs to change, and that isn't me - it's how
> the stable stuff operates.  Because it's very confusing and inconsistent
> at the moment.
> 
> Fix that problem and we can then all move along.  Continue to ignore it
> and I'll continue my crusade against this blatent inconsistency. :)

I'm still failing to see any inconsistency.

Ben.

-- 
Ben Hutchings
Theory and practice are closer in theory than in practice.
                                - John Levine, moderator of comp.compilers
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120902/6d4ce281/attachment.sig>
