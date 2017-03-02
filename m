From: jeyu@redhat.com (Jessica Yu)
Date: Thu, 2 Mar 2017 12:09:12 -0500
Subject: [PATCHv2 11/14] module: Use set_memory.h header
In-Reply-To: <1488413706-9739-12-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-12-git-send-email-labbott@redhat.com>
Message-ID: <20170302170912.GA13268@packer-debian-8-amd64.digitalocean.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Laura Abbott [01/03/17 16:15 -0800]:
>
>set_memory_* functions have moved to set_memory.h. Switch to this
>explicitly.
>
>Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Jessica Yu <jeyu@redhat.com>

Thanks,

Jessica

>---
> kernel/module.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 7eba6de..c0f04b3 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -49,6 +49,7 @@
> #include <linux/rculist.h>
> #include <linux/uaccess.h>
> #include <asm/cacheflush.h>
>+#include <asm/set_memory.h>
> #include <asm/mmu_context.h>
> #include <linux/license.h>
> #include <asm/sections.h>
>-- 
>2.7.4
>
