From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 11:39:38 +0100
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <20160106233656.GA9316@www.outflux.net>
References: <20160106233656.GA9316@www.outflux.net>
Message-ID: <3057830.IhsDfpk1rP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 January 2016 15:36:56 Kees Cook wrote:
> Building with CONFIG_CC_STACKPROTECTOR_STRONG triggers protection code
> generation under CONFIG_ARM_ATAG_DTB_COMPAT but this is too early for
> being able to use any of the stack_chk code. Explicitly disable it for
> only the atags_to_fdt bits.
> 
> Suggested-by: zhxihu <zhxihu@marvell.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
