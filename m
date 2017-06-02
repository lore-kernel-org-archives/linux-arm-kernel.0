From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 2 Jun 2017 12:08:16 +0100
Subject: [PATCH] arm64/kvm: fix misleading kconfig text for 16K pages
In-Reply-To: <1496401340-24802-1-git-send-email-mark.rutland@arm.com>
References: <1496401340-24802-1-git-send-email-mark.rutland@arm.com>
Message-ID: <56353731-e2ee-3784-8f22-6c300e6fa26c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/17 12:02, Mark Rutland wrote:
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

Thanks for fixing that up

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
