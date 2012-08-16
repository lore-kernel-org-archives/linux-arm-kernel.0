From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 16 Aug 2012 08:59:47 -0500
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
Message-ID: <502CFCD3.9010603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/10/2012 12:36 PM, Will Deacon wrote:
> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> 
> The arm_pmu_type enumeration was initially introduced to identify
> different PMU types in the system, the usual one being that on the CPU
> (ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
> the introduction of devicetree bindings for the CPU PMU, the enumeration
> is no longer required.
> 
> This patch removes the enumeration and updates the various CPU PMU
> platform devices so that they no longer pass an .id field referring
> to identify the PMU type.

Acked-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
