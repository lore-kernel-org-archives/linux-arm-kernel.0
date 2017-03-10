From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 18:42:24 +0000
Subject: [PATCH 00/15] arm64/kvm: use common sysreg definitions
In-Reply-To: <20170310183555.GB6271@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
 <87a88tv94d.fsf@on-the-bus.cambridge.arm.com>
 <20170310183555.GB6271@arm.com>
Message-ID: <20170310184224.GE24571@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 06:35:55PM +0000, Will Deacon wrote:
> On Fri, Mar 10, 2017 at 08:17:22AM +0000, Marc Zyngier wrote:
> > On Thu, Mar 09 2017 at  5:07:12 pm GMT, Mark Rutland <mark.rutland@arm.com> wrote:
> > The next question is how do we merge this. Obviously, we can't split it
> > between trees, and this is very likely to clash with anything that we
> > will merge on the KVM side (the sysreg table is a popular place).
> > 
> > Will, Catalin: Would it make sense to create a stable branch with these
> > patches, and merge it into both the arm64 and KVM trees? That'd make
> > things easier...
> 
> I think the scope for conflict on our side is pretty high too, so a shared
> branch might be the best way to go. I don't want to branch just yet though,
> so I'll probably wait a week or so before setting something in stone.

Sure thing.

Let me know if you want me to rebase this, otherwise I'll leave my
current branch as-is.

Thanks,
Mark.
