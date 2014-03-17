From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 17 Mar 2014 15:49:40 +0400
Subject: [PATCH] ARM: shmobile: koelsch-reference: Annotate clk_names
 as __initconst
In-Reply-To: <1395022796-3199-1-git-send-email-horms+renesas@verge.net.au>
References: <1395022796-3199-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5326E154.9040800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-03-2014 6:19, Simon Horman wrote:

    Apparently you meant clk_enables in the subject, not clk_names.

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

> diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
> index a39114a..63117d52 100644
> --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
> @@ -110,7 +110,7 @@ static const struct clk_name clk_names[] __initconst = {
>   /*
>    * This is a really crude hack to work around core platform clock issues
>    */
> -static const struct clk_name clk_enables[] = {
> +static const struct clk_name clk_enables[] __initconst = {

WBR, Sergei
