From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Sep 2016 16:44:00 +0100
Subject: [PATCH 2/2] MAINTAINERS: add ARM and arm64 EFI specific files to
 EFI subsystem
In-Reply-To: <1474472114-12973-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1474472114-12973-1-git-send-email-ard.biesheuvel@linaro.org>
 <1474472114-12973-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160921154400.GJ29042@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 04:35:14PM +0100, Ard Biesheuvel wrote:
> Since I will be co-maintaining the EFI subsystem, it makes sense to
> mention the ARM and arm64 EFI bits in the EFI section in MAINTAINERS
> so that Matt, the list and I get cc'ed on proposed changes.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 224518556a84..cc8b36699f94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4562,12 +4562,14 @@ L:	linux-efi at vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>  S:	Maintained
>  F:	Documentation/efi-stub.txt
> -F:	arch/ia64/kernel/efi.c
> +F:	arch/*/kernel/efi.c
>  F:	arch/x86/boot/compressed/eboot.[ch]
> -F:	arch/x86/include/asm/efi.h
> +F:	arch/*/include/asm/efi.h
>  F:	arch/x86/platform/efi/
>  F:	drivers/firmware/efi/
>  F:	include/linux/efi*.h
> +F:	arch/arm/boot/compressed/efi-header.S
> +F:	arch/arm64/kernel/efi-entry.S

For the arm64 bit,

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
