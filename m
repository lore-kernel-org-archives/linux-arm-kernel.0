From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:26:58 +0100
Subject: [PATCH 04/15] Platform: OLPC: Remove an unused include
In-Reply-To: <20181010172300.317643-5-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-5-lkundrak@v3.sk>
Message-ID: <20181104122657.GY23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:49, Lubomir Rintel wrote:
> Also, the header is x86 specific, while there are non-x86 OLPC machines.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/platform/olpc/olpc-ec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index f99b183d5296..35a21c66cd0d 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -15,7 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
>  
>  struct ec_cmd_desc {
>  	u8 cmd;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/c691bba9/attachment.sig>
