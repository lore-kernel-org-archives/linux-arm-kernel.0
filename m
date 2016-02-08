From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 14:42:22 +0000
Subject: [PATCH v3 05/23] arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
In-Reply-To: <1454522416-6874-6-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160208144222.GN6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:59:58PM +0000, Marc Zyngier wrote:
> Add a new ARM64_HAS_VIRT_HOST_EXTN features to indicate that the
> CPU has the ARMv8.1 VHE capability.
> 
> This will be used to trigger kernel patching in KVM.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
