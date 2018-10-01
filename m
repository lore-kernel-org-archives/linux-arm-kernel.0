From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 13:39:22 +0100
Subject: [PATCH 0/7] arm64: Workaround for Cortex-A76 erratum 1188873
In-Reply-To: <20180927161534.247926-1-marc.zyngier@arm.com>
References: <20180927161534.247926-1-marc.zyngier@arm.com>
Message-ID: <20181001123922.GB25071@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 05:15:27PM +0100, Marc Zyngier wrote:
> Marc Zyngier (7):
>   arm64: Add decoding macros for CP15_32 and CP15_64 traps
>   arm64: compat: Add separate CP15 trapping hook
>   arm64: compat: Add condition code checks and IT advance
>   arm64: compat: Add cp15_32 and cp15_64 handler arrays
>   arm64: compat: Add CNTVCT trap handler
>   arm64: compat: Add CNTFRQ trap handler
>   arm64: arch_timer: Add workaround for ARM erratum 1188873

Queued for 4.20. Thanks.

-- 
Catalin
