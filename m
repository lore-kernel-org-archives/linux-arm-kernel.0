From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 30 Jul 2014 15:18:05 +0100
Subject: [RFC PATCH 04/10] arm64: add EFI little endian constants to
 linker script
In-Reply-To: <1405955785-13477-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405955785-13477-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140730141805.GA15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jul, at 05:16:19PM, Ard Biesheuvel wrote:
> Similar to how text offset and kernel size are mangled to produce little
> endian constants for the Image header regardless of the endianness of the
> kernel, this adds a number of constants used in the EFI PE/COFF header which
> can only be calculated (and byte swapped) by the linker.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/image.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Where is this file? I can't find it in Linus' tree.

-- 
Matt Fleming, Intel Open Source Technology Center
