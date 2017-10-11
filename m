From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Oct 2017 18:11:48 +0100
Subject: [PATCH v3 25/28] arm64/sve: Detect SVE and activate runtime
 support
In-Reply-To: <1507660725-7986-26-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-26-git-send-email-Dave.Martin@arm.com>
Message-ID: <54bcf388-ee66-c3f3-8eca-d6553a7f2c54@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/17 19:38, Dave Martin wrote:
> This patch enables detection of hardware SVE support via the
> cpufeatures framework, and reports its presence to the kernel and
> userspace via the new ARM64_SVE cpucap and HWCAP_SVE hwcap
> respectively.
> 
> Userspace can also detect SVE using ID_AA64PFR0_EL1, using the
> cpufeatures MRS emulation.
> 
> When running on hardware that supports SVE, this enables runtime
> kernel support for SVE, and allows user tasks to execute SVE
> instructions and make of the of the SVE-specific user/kernel
> interface extensions implemented by this series.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

Looks good to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
