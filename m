From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 10:55:32 +0100
Subject: [PATCH 00/15] arm64/kvm: use common sysreg definitions
In-Reply-To: <20170329084146.GA15778@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
 <87a88tv94d.fsf@on-the-bus.cambridge.arm.com>
 <20170310183555.GB6271@arm.com>
 <20170322183512.GB27921@leverpostej>
 <20170328184828.GF8643@leverpostej> <20170328202931.GF20211@cbox>
 <20170329084146.GA15778@arm.com>
Message-ID: <20170329095532.GA23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 09:41:47AM +0100, Will Deacon wrote:
> On Tue, Mar 28, 2017 at 10:29:31PM +0200, Christoffer Dall wrote:
> > On Tue, Mar 28, 2017 at 07:48:28PM +0100, Mark Rutland wrote:
> > > On Wed, Mar 22, 2017 at 06:35:13PM +0000, Mark Rutland wrote:

> > > I think it would make sense for those to be in a common branch taken by
> > > both the arm64 and KVM trees, with the KVM-specific parts being taken by
> > > KVM alone atop of that.
> > > 
> > > Would everyone be happy with that?
> > 
> > I'm happy with that.
> > 
> > > For reference, I've updated my branches so that arm64/common-sysreg only
> > > contains the common parts, with the KVM parts atop of that in
> > > kvm/common-sysreg.
> > 
> > Will, Catalin:  Let me know if you're going to pull from common-sysreg
> > and I'll do the same and add the kvm patches above.
> 
> I think that's what we'll do, but Catalin's out this week (we're taking it
> in turns to go to work). I'd say go ahead and pull it into kvm if there
> aren't any conflicts. No need to wait for us.
> 
> Mark -- those branches are stable, right?

They are now. I will not touch either branch.

Thanks,
Mark.
