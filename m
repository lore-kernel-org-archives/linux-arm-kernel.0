From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 15:18:09 +0000
Subject: [PATCH v6 00/12] arm-cci: PMU driver updates
In-Reply-To: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160222151808.GI3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:21:05AM +0000, Suzuki K. Poulose wrote:
> Suzuki K. Poulose (11):
>   arm-cci: Group writes to counter
>   arm-cci: Refactor CCI PMU enable/disable methods
>   arm-cci: Delay PMU counter writes to pmu::pmu_enable
>   arm-cci: write_counter: Remove redundant check
>   arm-cci: Get the status of a counter
>   arm-cci: Add routines to save/restore all counters
>   __cci_pmu_enable: Make counter sync optional
>   arm-cci: Provide hook for writing to PMU counters
>   arm-cci: CCI-500: Work around PMU counter writes
>   arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
>   arm-cci: CoreLink CCI-550 PMU driver

These generally look fine. If you can fix up for my other comments,
then for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
