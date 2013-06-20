From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Jun 2013 14:54:33 +0530
Subject: [PATCH 1/2] ARM: davinci: fix for build breakage for tnetv107x
 platforms
In-Reply-To: <1371203869-16308-2-git-send-email-avinashphilipk@gmail.com>
References: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
 <1371203869-16308-2-git-send-email-avinashphilipk@gmail.com>
Message-ID: <51C2CA51.5030705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:27 PM, Philip Avinash wrote:
> Fix the following build breakage and section mismatch error. This build
> break will comes only on removal of NEED_MACH_GPIO_H select option for
> ARCH-DAVINCI.
> 
> arch/arm/mach-davinci/board-tnetv107x-evm.c:283:15: error:
> 'davinci_timer_init' undeclared here (not in a function)
> arch/arm/mach-davinci/board-tnetv107x-evm.c:285:15: error:
> 'davinci_init_late' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-davinci/board-tnetv107x-evm.o] Error 1

Can you note the section mismatch error you saw too?

Thanks,
Sekhar
