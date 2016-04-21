From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Apr 2016 14:54:50 +0100
Subject: [PATCH v6 7/7] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <1461243525-13603-8-git-send-email-ashoks@broadcom.com>
References: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
 <1461243525-13603-8-git-send-email-ashoks@broadcom.com>
Message-ID: <20160421135450.GO6879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 05:58:45AM -0700, Ashok Kumar wrote:
> +static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
> +{
> +	armv8_pmu_init(cpu_pmu);
> +	cpu_pmu->name			= "armv8_brcm_vulcan";

Are we happy with "brcm" being the exposed userspace name? It might be
better to have this as "armv8_broadcom_vulcan".

I'll leave that to you and Will. Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
