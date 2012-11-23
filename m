From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Nov 2012 15:18:50 +0000
Subject: [PATCH v4 1/5] ARM: arch_timers: switch to physical timers if
 HYP mode is available
In-Reply-To: <20121110154605.3274.70574.stgit@chazy-air>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154605.3274.70574.stgit@chazy-air>
Message-ID: <20121123151850.GI32200@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:46:05PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> If we're booted in HYP mode, it is possible that we'll run some
> kind of virtualized environment. In this case, it is a better to
> switch to the physical timers, and leave the virtual timers to
> guests.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Seems simple enough.

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
