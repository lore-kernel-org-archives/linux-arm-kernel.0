From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Jan 2014 18:22:07 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
References: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
 <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
 <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
Message-ID: <20140127182207.GB8367@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:48:15PM +0000, Antti P Miettinen wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > That's why I defined the worst case. How did you implemented it in your
> > idle drivers ? That would help generalize it, after all these bindings
> > are there to simplify drivers upstreaming, feedback welcome.
> 
> Currently we do not handle this well downstream either. The problem
> with worst case is that the absolute worst case can be really bad and
> probability of it might be very low. Sorry - no ready answer :-)

Point taken, but these bindings still get us to a point that is much
better than today situation. After all, if the worst case can happen
either we design for worst case or we update parameters at runtime in
the kernel (which is not happening as of now) according to a notification
mechanism.

It is certainly worth investigating, probably we can define OPPs as
generic (ie not tied to the CPU), as performance point or system
operating points. I will think about this.

In the meantime if you have further pieces of feedback please keep them
coming.

Thanks,
Lorenzo
