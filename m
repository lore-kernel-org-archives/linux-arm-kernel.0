From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:12:35 +0100
Subject: [PATCH] ARM: nspire: Fix compiler warning
In-Reply-To: <1395339911-30009-1-git-send-email-shc_work@mail.ru>
References: <1395339911-30009-1-git-send-email-shc_work@mail.ru>
Message-ID: <201403262312.35470.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Alexander Shiyan wrote:
> CC      arch/arm/mach-nspire/nspire.o
> arch/arm/mach-nspire/nspire.c:79:2: warning: initialization from incompatible pointer type [enabled by default]
> arch/arm/mach-nspire/nspire.c:79:2: warning: (near initialization for '__mach_desc_NSPIRE.restart') [enabled by default]
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-nspire/nspire.c | 2 +-

Applied to fixes branch, thanks!

	Arnd
