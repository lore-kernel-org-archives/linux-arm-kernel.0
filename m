From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Nov 2015 14:27:41 +0000
Subject: [PATCH 0/2] arm64 STRICT_MM_TYPECHECKS fixes
In-Reply-To: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151109142740.GB21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 09:55:44AM +0100, Ard Biesheuvel wrote:
> Just a couple of things I spotted when building with STRICT_MM_TYPECHECKS
> enabled, one of which is in new code (current merge window) and the other
> is in code that I introduced myself in the FDT fixmap remapping code.
> 
> Ard Biesheuvel (2):
>   arm64: fix STRICT_MM_TYPECHECKS issue in PTE_CONT manipulation
>   arm64: fix R/O permissions of FDT mapping

Both patches applied.

-- 
Catalin
