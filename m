From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Apr 2017 17:13:35 +0100
Subject: [PATCHv2 00/16] arm_pmu: ACPI support
In-Reply-To: <20170407143006.GP19342@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <20170407143006.GP19342@arm.com>
Message-ID: <20170407161335.GC858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 03:30:06PM +0100, Will Deacon wrote:
> On Thu, Apr 06, 2017 at 07:29:07PM +0100, Mark Rutland wrote:
> > This series implements ACPI support in the ARM PMU code. It borrows some code
> > from Jeremy's series [1], but takes a different approach to probing and
> > association, using the usual hotplug state machine, minimising external changes
> > required, and simplifying the relationship with the common arm_pmu code.
> 
> Patches 12 and 13 seem unrelated to this series, and I've made some small
> comments on a couple of other patches.

Those were cleanup that relied on the GICC rework in this series.

I'll drop those for v3, and send them separately once the rest is in.

Thanks,
Mark.
