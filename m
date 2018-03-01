From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Mar 2018 18:37:32 +0000
Subject: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
In-Reply-To: <20180301162803.5490-1-robh@kernel.org>
References: <20180301162803.5490-1-robh@kernel.org>
Message-ID: <20180301183732.52ntz5trt26vpuhh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 10:28:03AM -0600, Rob Herring wrote:
> libfdt gained a new dependency on strrchr, so make it available to the
> EFI namespace before we update libfdt.
> 
> Thanks to Ard for providing this fix.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. This is a dependency on a dtc upstream sync.

So I assume you'll merge this patch via the DT tree and we don't need to
pick it up through the arm64 tree.

-- 
Catalin
