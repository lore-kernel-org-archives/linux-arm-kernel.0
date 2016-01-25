From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 25 Jan 2016 13:20:01 +0100
Subject: [PATCH] ARM: tango: use "depends on" instead of "if" after prompt
In-Reply-To: <1453722044-23005-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453722044-23005-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <56A612F1.7080105@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/2016 12:40, Masahiro Yamada wrote:

> This platform was recently added, so missed the global fixup by
> commit e32465429490 ("ARM: use "depends on" for SoC configs instead
> of "if" after prompt").  Fix it now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-tango/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
