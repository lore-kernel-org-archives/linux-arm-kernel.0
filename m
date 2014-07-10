From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jul 2014 10:22:28 +0100
Subject: [PATCHv3][REBASED] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <1403736903-25594-1-git-send-email-lauraa@codeaurora.org>
References: <1403736903-25594-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140710092227.GF16137@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 11:55:03PM +0100, Laura Abbott wrote:
> arm64 currently lacks support for -fstack-protector. Add
> similar functionality to arm to detect stack corruption.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/Kconfig                      |  1 +
>  arch/arm64/include/asm/stackprotector.h | 38 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/process.c             |  6 ++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 arch/arm64/include/asm/stackprotector.h

Applied for 3.17. Thanks.

-- 
Catalin
