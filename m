From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 11 Jun 2015 17:23:40 +0100
Subject: [PATCH] arm: dts: vexpress: describe all PMUs in TC2 dts
In-Reply-To: <1434039331-14504-1-git-send-email-mark.rutland@arm.com>
References: <1434039331-14504-1-git-send-email-mark.rutland@arm.com>
Message-ID: <5579B60C.3000009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/06/15 17:15, Mark Rutland wrote:
> The dts for the CoreTile Express A15x2 A7x3 (TC2) only describes the
> PMUs of the Cortex-A15 CPUs, and not the Cortex-A7 CPUs.
>
> Now that we have a mechanism for describing disparate PMUs and their
> interrupts in device tree, this patch makes use of these to describe the
> PMUs for all CPUs in the system. For consistency, the existing A15 PMU
> interrupt-affinity property is reflowed across two lines.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> This was previously posted along with the corresponding support code [1], which
> is now queued in Will's perf/updates branch [2], for v4.2. I've rebased it atop
> of Sudeep's interrupt-affinity addition, but otherwise it's identical.
>
> Liviu, Lorenzo, Sudeep, are you happy to ack this and/or queue it up to follow
> the support code?

Looks fine to me

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
