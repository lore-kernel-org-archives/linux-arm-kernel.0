From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Mar 2017 16:03:32 +0000
Subject: [PATCH 0/2] arm64: head.S cleanup
In-Reply-To: <f11d505b-f27c-e42c-5131-86363bcca9b0@arm.com>
References: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
 <20170321153711.GC8319@e104818-lin.cambridge.arm.com>
 <f11d505b-f27c-e42c-5131-86363bcca9b0@arm.com>
Message-ID: <20170321160331.GC21829@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 03:51:55PM +0000, Marc Zyngier wrote:
> On 21/03/17 15:37, Catalin Marinas wrote:
> > On Wed, Feb 15, 2017 at 02:54:15PM +0000, Mark Rutland wrote:
> >> Mark Rutland (2):
> >>   arm64: reduce el2_setup branching
> >>   arm64: move !VHE work to end of el2_setup
> > 
> > Mark, Marc, do these patches conflict with the hyp stub cleanup? If
> > there is some overlap, I'm happy for them to go via the kvm tree
> > together with the others.
> 
> I don't think there is any overlap, my changes stay clear of head.S.

Thanks (for the ack as well). Queued for 4.12.

-- 
Catalin
