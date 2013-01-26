From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 27 Jan 2013 00:08:44 +0400
Subject: [RFC V2 PATCH 3/8] ARM: kirkwood: nsa310: cleanup includes and
 unneeded code
In-Reply-To: <31142087d93c2713d067f4ccf470810e6e71f17b.1359091286.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <31142087d93c2713d067f4ccf470810e6e71f17b.1359091286.git.jason@lakedaemon.net>
Message-ID: <510437CC.1040106@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2013 9:32, Jason Cooper wrote:

> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>   arch/arm/mach-kirkwood/board-nsa310.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

> diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
> index 1bd328d..0b99533 100644
> --- a/arch/arm/mach-kirkwood/board-nsa310.c
> +++ b/arch/arm/mach-kirkwood/board-nsa310.c
> @@ -10,11 +10,8 @@
>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> -#include <linux/i2c.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
>   #include <mach/kirkwood.h>
> +#include <linux/of.h>

    You also add an #include and don't mention it anywhere. Or is that part of 
the cleanup?

WBR, Sergei
