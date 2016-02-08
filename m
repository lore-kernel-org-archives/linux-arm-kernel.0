From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 14:41:47 +0000
Subject: [PATCH v3 03/23] arm/arm64: Add new is_kernel_in_hyp_mode
 predicate
In-Reply-To: <1454522416-6874-4-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160208144146.GM6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:59:56PM +0000, Marc Zyngier wrote:
> With ARMv8.1 VHE extension, it will be possible to run the kernel
> at EL2 (aka HYP mode). In order for the kernel to easily find out
> where it is running, add a new predicate that returns whether or
> not the kernel is in HYP mode.
> 
> For completeness, the 32bit code also get such a predicate (always
> returning false) so that code common to both architecture (timers,
> KVM) can use it transparently.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
