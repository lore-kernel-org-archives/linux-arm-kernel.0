From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 30 Oct 2015 10:40:28 -0500
Subject: [PATCH] arm64/efi: move arm64 specific stub C code to libstub
In-Reply-To: <1445611694-31838-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1445611694-31838-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56338F6C.8040207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 09:48 AM, Ard Biesheuvel wrote:
> Now that we added special handling to the C files in libstub, move
> the one remaining arm64 specific EFI stub C file to libstub as
> well, so that it gets the same treatment. This should prevent future
> changes from resulting in binaries that may execute incorrectly in
> UEFI context.
>
> With efi-entry.S the only remaining EFI stub source file under
> arch/arm64, we can also simplify the Makefile logic somewhat.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'm a little late here, but I've been running this for a few days in an 
EFI/ACPI environment without any issues.

So if there are any further merges..

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks,
