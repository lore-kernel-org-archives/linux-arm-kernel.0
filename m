From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 15 Jul 2016 16:22:15 +0100
Subject: [PATCH v2 2/2] efi/arm*: esrt: add missing call to efi_esrt_init()
In-Reply-To: <1468263646-28184-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
 <1468263646-28184-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160715152215.GE2406@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jul, at 09:00:46PM, Ard Biesheuvel wrote:
> ESRT support is built by default for all architectures that define
> CONFIG_EFI. However, this support was not wired up yet for ARM/arm64,
> since efi_esrt_init() was never called. So add the missing call.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/arm-init.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks Ard, applied and queued up for v4.9 on top of the EFI memmap
refactoring.
