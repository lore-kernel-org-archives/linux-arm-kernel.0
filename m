From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 2 Jun 2017 15:18:30 +0200
Subject: [PATCH] arm64/kvm: fix misleading kconfig text for 16K pages
In-Reply-To: <1496401340-24802-1-git-send-email-mark.rutland@arm.com>
References: <1496401340-24802-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170602131830.GC397@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 12:02:20PM +0100, Mark Rutland wrote:
> We've supported KVM with 16K pages since commit:
> 
>   02e0b7600f835007 ("arm64: kvm: Add support for 16K pages")
> 
> ... yet the kconfig text says this combination is not supported.
> 
> Let's fix that by deleting the misleading text.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu

Acked-by: Christoffer Dall <cdall@linaro.org>
