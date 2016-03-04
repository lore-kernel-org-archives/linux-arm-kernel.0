From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Mar 2016 18:12:57 +0000
Subject: [PATCH] arm64: efi: add missing frame pointer assignment
In-Reply-To: <1457022692-14043-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457022692-14043-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160304181257.GC13403@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 05:31:32PM +0100, Ard Biesheuvel wrote:
> The prologue of the EFI entry point pushes x29 and x30 onto the stack but
> fails to create the stack frame correctly by omitting the assignment of x29
> to the new value of the stack pointer. So fix that.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi-entry.S | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

-- 
Catalin
