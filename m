From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Apr 2016 17:38:40 +0100
Subject: [PATCH 0/8] arm64: kaslr cleanups and improvements
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160425163840.GG9614@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 05:09:40PM +0200, Ard Biesheuvel wrote:
> Ard Biesheuvel (8):
>   arm64: kernel: don't export local symbols from head.S
>   arm64: kernel: use literal for relocated address of
>     __secondary_switched
>   arm64: kernel: perform relocation processing from ID map
>   arm64: introduce mov_q macro to move a constant into a 64-bit register
>   arm64: kernel: replace early 64-bit literal loads with move-immediates
>   arm64: don't map TEXT_OFFSET bytes below the kernel if we can avoid it
>   arm64: relocatable: deal with physically misaligned kernel images
>   arm64: kaslr: increase randomization granularity

I went through these patches and there is indeed a nice clean-up. The
increased KASLR granularity also looks fine. So, for the series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
