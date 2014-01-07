From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jan 2014 15:46:23 +0000
Subject: [PATCH v8 6/7] arm64, jump label: optimize jump label
 implementation
In-Reply-To: <1389104234-15239-7-git-send-email-liuj97@gmail.com>
References: <1389104234-15239-1-git-send-email-liuj97@gmail.com>
 <1389104234-15239-7-git-send-email-liuj97@gmail.com>
Message-ID: <20140107154622.GA4399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:17:13PM +0000, Jiang Liu wrote:
> Optimize jump label implementation for ARM64 by dynamically patching
> kernel text.
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/jump_label.h | 52 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/Makefile          |  1 +
>  arch/arm64/kernel/jump_label.c      | 58 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 arch/arm64/include/asm/jump_label.h
>  create mode 100644 arch/arm64/kernel/jump_label.c

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks for sticking with this! I think this series is good for merging now.

Will
