From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Sep 2012 18:04:34 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <1346594067.4958.7.camel@deadeye.wl.decadent.org.uk>
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
Message-ID: <20120902170434.GA31141@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 02, 2012 at 02:54:27PM +0100, Ben Hutchings wrote:
> On Sat, 2012-09-01 at 21:11 +0100, Russell King - ARM Linux wrote:
> [...]
> > It is as clear as mud now when stable at vger.kernel.org should be Cc'd and
> > when it should not.
> [...]
> 
> Perhaps what you're missing is that it's an open mailing list (as was
> stable at kernel.org), not an alias for 'the stable team'.  As with any
> other kernel mailing list, you don't need to get explicit permission to
> send mail to it.  So there is no 'should not'.

Then please explain why people keep getting Greg's standard form "this
is not how you submit patches for stable" when they CC a _discussion_
to the address.

What you're saying does not tie up with what _actually_ happens in
reality.  Therefore I can only believe that you are wrong, even though
you may be part of "the stable team".

Please get your (collective) policy sorted out and properly documented,
and you _all_ start behaving consistently.  If you want
stable at vger.kernel.org to be a list for discussion of stable patches,
then fine - just don't then send standard form emails telling people
they did something wrong when they _do_ try to use it for discussion.

As I have pointed out many times in this thread, there is inconsistency
between what you are saying, what Greg has said, what the documentation
says, and the reaction that people get from Greg when they do send to
that address.  Something needs to change, and that isn't me - it's how
the stable stuff operates.  Because it's very confusing and inconsistent
at the moment.

Fix that problem and we can then all move along.  Continue to ignore it
and I'll continue my crusade against this blatent inconsistency. :)
