From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 Nov 2015 12:38:43 +0100
Subject: [PATCH] ARM64: use linux/types.h in kvm.h
In-Reply-To: <9679324.UdV9GV0mFA@wuerfel>
References: <9679324.UdV9GV0mFA@wuerfel>
Message-ID: <20151113113843.GG12968@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 03:41:08PM +0100, Arnd Bergmann wrote:
> We should always use linux/types.h instead of asm/types.h for
> consistency, and Kbuild actually warns about it:
> 
> ./usr/include/asm/kvm.h:35: include of <linux/types.h> is preferred over <asm/types.h>
> 
> This patch does as Kbuild asks us.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I don't see this error when building the kernel, does it require a
special option to check for these things?


In any case, thanks for the patch, I have applied it.

-Christoffer
