From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 4 Feb 2016 16:13:01 +0000
Subject: [PATCH v2 0/7] ARM/efi minor fixes + stub pre-boot compat checks
In-Reply-To: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160204161300.GC17587@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 04:50:23PM +0100, Ard Biesheuvel wrote:
> Ard Biesheuvel (7):
>   arm64: efistub: drop __init annotation from handle_kernel_image()
>   arm64: vmlinux.lds.S: handle .init.rodata.xxx and .init.bss sections
>   efi: efistub: prevent __init annotations from being used
>   efi: arm-init: use read-only early mappings
>   ARM: efistub: check for LPAE support before booting a LPAE kernel
>   arm64: efistub: check for h/w support before booting a >4 KB granule
>     kernel
>   ARM/arm64: efistub: perform hardware compatibility check

This all looks good to be, so FWIW, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
