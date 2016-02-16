From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 22:24:10 +0100
Subject: [PATCH] ARM: drop unused DEBUG_RODATA from XIP_KERNEL
In-Reply-To: <20160216202957.GA1826@www.outflux.net>
References: <20160216202957.GA1826@www.outflux.net>
Message-ID: <5884144.R9YAlf8Dgt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 12:29:57 Kees Cook wrote:
> With CONFIG_DEBUG_RODATA not being sensible under XIP_KERNEL, remove it
> from the XIP linker script.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
