From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Oct 2017 16:18:26 +0100
Subject: [PATCH v5 4/6] perf: hisi: Add support for HiSilicon SoC HHA PMU
 driver
In-Reply-To: <1503389277-134131-5-git-send-email-zhangshaokun@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-5-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20171017151826.acumob5ldoueiyg6@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 04:07:55PM +0800, Shaokun Zhang wrote:
> L3 cache coherence is maintained by Hydra Home Agent (HHA) in HiSilicon
> SoC. This patch adds support for HHA PMU driver, Each HHA has own
> control, counter and interrupt registers and is an separate PMU. For
> each HHA PMU, it has 16-programable counters and each counter is
> free-running. Interrupt is supported to handle counter (48-bits)
> overflow.

My comments here are the same as for the L3C PMU driver.

Thanks,
Mark.
