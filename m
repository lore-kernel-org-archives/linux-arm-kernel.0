From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 25 Jan 2016 13:10:37 +0100
Subject: [PATCH] ARM: tango: use const and __initconst for smp_operations
In-Reply-To: <1453721622-15437-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453721622-15437-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <56A610BD.9010608@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/2016 12:33, Masahiro Yamada wrote:

> This newly added code missed the global fixup by commit 75305275a721
> ("ARM: use const and __initconst for smp_operations").  So fix it now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-tango/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
