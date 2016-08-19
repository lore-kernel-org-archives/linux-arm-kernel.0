From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 19 Aug 2016 12:57:57 +0100
Subject: [PATCH v2] efi: arm64: add debugfs node to dump UEFI runtime
 page tables
In-Reply-To: <1471349601-31257-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471349601-31257-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160819115757.GT30909@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Aug, at 02:13:21PM, Ard Biesheuvel wrote:
> Register the debugfs node 'efi_page_tables' to allow the UEFI runtime
> page tables to be inspected. Note that ARM does not have 'asm/ptdump.h'
> [yet] so for now, this is arm64 only.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: test for CONFIG_ARM64_PTDUMP rather than CONFIG_ARM64
>     add Mark's ack
> 
>  drivers/firmware/efi/arm-runtime.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Thanks Ard. Queued up in 'next'.
