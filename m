From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 May 2018 14:39:04 +0100
Subject: [PATCH v2 04/17] arm64: Add ARCH_WORKAROUND_2 probing
In-Reply-To: <20180529121121.24927-5-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
 <20180529121121.24927-5-marc.zyngier@arm.com>
Message-ID: <4461a4e7-e620-aec6-0f58-674080418e80@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/18 13:11, Marc Zyngier wrote:
> As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
> discovery mechanism for detecting the SSBD mitigation.
> 
> A new capability is also allocated for that purpose, and a
> config option.
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
