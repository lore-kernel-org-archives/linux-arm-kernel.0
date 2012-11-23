From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Nov 2012 15:23:38 +0000
Subject: [PATCH v4 2/5] ARM: KVM: arch_timers: Add minimal infrastructure
In-Reply-To: <20121110154611.3274.87138.stgit@chazy-air>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154611.3274.87138.stgit@chazy-air>
Message-ID: <20121123152338.GJ32200@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:46:12PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add some very minimal architected timer related infrastructure.
> For the moment, we just provide empty structures, and enable/disable
> access to the physical timer across world switch.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

Is it even worth having this patch? It doesn't seem to do much other than
stub everything out, so I'd be inclined to fold it in with the next one.

Will
