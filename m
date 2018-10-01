From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Oct 2018 10:48:15 +0100
Subject: [PATCH] arm64: remove unused asm/compiler.h header file
In-Reply-To: <20180927130737.31301-1-ard.biesheuvel@linaro.org>
References: <20180927130737.31301-1-ard.biesheuvel@linaro.org>
Message-ID: <20181001094814.GA30342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 03:07:37PM +0200, Ard Biesheuvel wrote:
> arm64 does not define CONFIG_HAVE_ARCH_COMPILER_H, nor does it keep
> anything useful in its copy of asm/compiler.h, so let's remove it
> before anybody starts using it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/compiler.h | 30 ------------------------------
>  arch/arm64/include/asm/sysreg.h   |  1 -
>  arch/arm64/include/asm/uaccess.h  |  1 -
>  arch/arm64/kernel/psci.c          |  1 -
>  4 files changed, 33 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/compiler.h

Acked-by: Will Deacon <will.deacon@arm.com>

Will
