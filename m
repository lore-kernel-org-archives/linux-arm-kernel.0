From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 29 Oct 2014 14:23:37 +0000
Subject: [PATCH 1/1] bus: cci: move away from arm_pmu framework
In-Reply-To: <1413826531-23462-2-git-send-email-mark.rutland@arm.com> (Mark
 Rutland's message of "Mon, 20 Oct 2014 18:35:31 +0100")
References: <1413826531-23462-1-git-send-email-mark.rutland@arm.com>
 <1413826531-23462-2-git-send-email-mark.rutland@arm.com>
Message-ID: <9hhzjcfeyza.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:

> The ARM CPU PMUs and the ARM CCI PMU are using the same framework
> despite being substantially different in programming model, which makes
> it difficult to handle either particularly well.
>
> This patch migrates the ARM CCI PMU driver away from the arm_pmu
> framework, matching the style of the CCN PMU driver and other 'uncore'
> PMU drivers. This enables better support for the CCI PMU (including
> migration of events across CPUs across hotplug) and will allow for
> refactoring of the arm_pmu framework to better support CPU PMUs.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>

Looks good!

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

[...]
