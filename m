From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Sep 2012 22:51:37 +0100
Subject: [PATCH v2] ARM: perf: add guest vs host discrimination
In-Reply-To: <1347550846-10158-1-git-send-email-marc.zyngier@arm.com>
References: <1347550846-10158-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120913215137.GA22159@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 04:40:46PM +0100, Marc Zyngier wrote:
> Add minimal guest support to perf, so it can distinguish whether
> the PMU interrupt was in the host or the guest, as well as collecting
> some very basic information (guest PC, user vs kernel mode).
> 
> This is not feature complete though, as it doesn't support backtracing
> in the guest.
> 
> Based on the x86 implementation, tested with KVM/ARM.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Hi Will,
> 
> This is v2 of this patch, based on your perf/updates branch.
> If you don't have any additional comment, can you please merge it?

Cheers Marc, I've applied this on top of the same branch and will likely
get it queued for 3.8 (I've already got a fair amount pending for 3.7).

Looking forward to the guest backtracer :)

Will
