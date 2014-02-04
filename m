From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Feb 2014 17:30:22 +0000
Subject: [PATCH v3 2/3] arm64: Add audit support
In-Reply-To: <1391410590-4884-3-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
 <1391410590-4884-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140204173021.GF664@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 06:56:29AM +0000, AKASHI Takahiro wrote:
> On AArch64, audit is supported through generic lib/audit.c and
> compat_audit.c, and so this patch adds arch specific definitions required.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/Kconfig               |    1 +
>  arch/arm64/include/asm/syscall.h |   15 +++++++++++++++
>  include/uapi/linux/audit.h       |    1 +
>  3 files changed, 17 insertions(+)

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
