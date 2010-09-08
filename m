From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 8 Sep 2010 09:28:32 +0100
Subject: [RFC PATCH 0/3] Convert RealView/Versatile platforms to
	physmap-flash
In-Reply-To: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
References: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <000001cb4f2f$d2a30f70$77e92e50$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas
> Sent: 07 September 2010 13:49

> I've had this patches in my tree for some time but forgot about them.
> Is
> there a reason why we need to use the integrator flash and not convert
> to the physmap-flash? It gives us the same functionality. If converting
> the Integrator boards, we can even remove the integrator flash support.

Does this still support the concatenation of the two flash devices into one
large device?

Colin
