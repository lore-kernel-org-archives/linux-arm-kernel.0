From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Oct 2014 10:02:28 +0100
Subject: [PATCH v4] arm/arm64: KVM: map MMIO regions at creation time
In-Reply-To: <1412953232-11699-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1412953232-11699-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <8b22fcf0e74c995572b8c0d8debdb386@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-10-10 16:00, Ard Biesheuvel wrote:
> There is really no point in faulting in memory regions page by page
> if they are not backed by demand paged system RAM but by a linear
> passthrough mapping of a host MMIO region. So instead, detect such
> regions at setup time and install the mappings for the backing all
> at once.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

         M.
-- 
Fast, cheap, reliable. Pick two.
