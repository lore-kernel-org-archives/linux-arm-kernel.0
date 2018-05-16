From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 May 2018 11:47:32 +0100
Subject: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
In-Reply-To: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180516104732.dxt7di6t4hcss23e@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 04:46:26PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for ARM64-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 4.18. Thanks.

-- 
Catalin
