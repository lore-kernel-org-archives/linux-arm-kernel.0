From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Apr 2017 17:03:47 +0100
Subject: [PATCH v2] arm64: relocation testing module
In-Reply-To: <1490946933-9674-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1490946933-9674-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170404160346.GD19969@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 08:55:33AM +0100, Ard Biesheuvel wrote:
> This module tests the module loader's ELF relocation processing
> routines. When loaded, it logs output like below.
> 
>     Relocation test:
>     -------------------------------------------------------
>     R_AARCH64_ABS64                 0xffff880000cccccc pass
>     R_AARCH64_ABS32                 0x00000000f800cccc pass
>     R_AARCH64_ABS16                 0x000000000000f8cc pass
>     R_AARCH64_MOVW_SABS_Gn          0xffff880000cccccc pass
>     R_AARCH64_MOVW_UABS_Gn          0xffff880000cccccc pass
>     R_AARCH64_ADR_PREL_LO21         0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL64                0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL32                0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL16                0xffffff9cf4d1a400 pass
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Queued for 4.12. Thanks.

-- 
Catalin
