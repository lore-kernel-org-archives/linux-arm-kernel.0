From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 08 Sep 2010 15:58:23 +0100
Subject: [RFC PATCH 0/3] Convert RealView/Versatile platforms
	tophysmap-flash
In-Reply-To: <000001cb4f2f$d2a30f70$77e92e50$@tuckley@arm.com>
References: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
	<000001cb4f2f$d2a30f70$77e92e50$@tuckley@arm.com>
Message-ID: <1283957903.10137.53.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-08 at 09:28 +0100, Colin Tuckley wrote:
> > -----Original Message-----
> > From: Catalin Marinas
> > Sent: 07 September 2010 13:49
> 
> > I've had this patches in my tree for some time but forgot about them.
> > Is
> > there a reason why we need to use the integrator flash and not convert
> > to the physmap-flash? It gives us the same functionality. If converting
> > the Integrator boards, we can even remove the integrator flash support.
> 
> Does this still support the concatenation of the two flash devices into one
> large device?

Yes.

-- 
Catalin
