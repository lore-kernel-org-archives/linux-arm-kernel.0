From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 19 Aug 2011 12:37:09 +0800
Subject: [PATCH] ARM: mach-footbridge: add missing header file
	<video/vga.h>
In-Reply-To: <1313575204-25374-1-git-send-email-bryan.wu@canonical.com>
References: <1313575204-25374-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <CAK5ve-+0rtcC8KiEW9=WHnW8nPTr8+7tmnqUgZJQ_3GV6gMpzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Also this one. any comment?

Thanks,
-Bryan

On Wed, Aug 17, 2011 at 6:00 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> This patch fixes following building error:
> --
> arch/arm/mach-footbridge/dc21285.c: In function 'dc21285_preinit':
> arch/arm/mach-footbridge/dc21285.c:299:2: error: 'vga_base' undeclared (first use in this function)
> arch/arm/mach-footbridge/dc21285.c:299:2: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/mach-footbridge/dc21285.o] Error 1
> --
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> ?arch/arm/mach-footbridge/dc21285.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
> index 1331fff..18c32a5 100644
> --- a/arch/arm/mach-footbridge/dc21285.c
> +++ b/arch/arm/mach-footbridge/dc21285.c
> @@ -18,6 +18,7 @@
> ?#include <linux/irq.h>
> ?#include <linux/io.h>
> ?#include <linux/spinlock.h>
> +#include <video/vga.h>
>
> ?#include <asm/irq.h>
> ?#include <asm/system.h>
> --
> 1.7.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
