From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 26 Feb 2016 14:43:30 +0000
Subject: [PATCH 1/2] efi: get rid of EFI_SYSTEM_TABLES status bit
In-Reply-To: <1456496435-12679-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456496435-12679-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160226144330.GB7475@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb, at 03:20:34PM, Ard Biesheuvel wrote:
> The EFI_SYSTEM_TABLES status bit is set by all EFI supporting architectures
> upon discovery of the EFI system table, but the bit is never tested in any
> code we have in the tree. So remove it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/ia64/kernel/efi.c             | 2 --
>  arch/x86/platform/efi/efi.c        | 2 --
>  drivers/firmware/efi/arm-runtime.c | 1 -
>  include/linux/efi.h                | 1 -
>  4 files changed, 6 deletions(-)

Oops. Looks good, thanks Ard.
