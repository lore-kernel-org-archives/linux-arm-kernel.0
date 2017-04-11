From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Apr 2017 16:45:57 +0100
Subject: [PATCHv3 00/14] arm_pmu: ACPI support
In-Reply-To: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170411154557.GD17109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 09:39:43AM +0100, Mark Rutland wrote:
> This series implements ACPI support in the ARM PMU code. It borrows some code
> from Jeremy's series [1], but takes a different approach to probing and
> association, using the usual hotplug state machine, minimising external changes
> required, and simplifying the relationship with the common arm_pmu code.
> 
> The first few patches are preparatory cleanup/refactoring, with the latter half
> of the series being specific to ACPI support.
> 
> The series is based on Will's perf/updates branch [2]. I've pushed the whole
> series out to the arm/perf/acpi branch [3] of my kernel.org repo.

Thanks, I've queued this up so it should appear in linux-next shortly.

Will
