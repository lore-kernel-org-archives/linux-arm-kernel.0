From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 16:11:40 +0200
Subject: [PATCH] ARM: nspire: Fix Kconfig dependency
In-Reply-To: <1464807997-3804-1-git-send-email-shc_work@mail.ru>
References: <1464807997-3804-1-git-send-email-shc_work@mail.ru>
Message-ID: <6163761.BtjIhoCnEq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 1, 2016 10:06:37 PM CEST Alexander Shiyan wrote:
> ARM926T-based machine should depend on the ARCH_MULTI_V5 option.
> The ARCH_MULTI_V4_V5 is selected automatically by basic ARM configuration.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-nspire/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I found this in the backlog of unmerged patches, applied to next/cleanup now.

	Arnd
