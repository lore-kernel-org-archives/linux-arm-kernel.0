From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 21 Nov 2011 12:39:15 +0800
Subject: [PATCH V1] ARM: mmp: fix gpio operation error
In-Reply-To: <1321846364-30466-2-git-send-email-zhangwm@marvell.com>
References: <1321846364-30466-1-git-send-email-zhangwm@marvell.com>
 <1321846364-30466-2-git-send-email-zhangwm@marvell.com>
Message-ID: <CAN1soZwLY=B8J+-5DfV15DOm7+Mx2Mz_b+hT5Hu-+8jENCXHfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 11:32 AM, Neil Zhang <zhangwm@marvell.com> wrote:
> Fix the following build error on Marvell mmp platform.
>
> In file included from arch/arm/mach-mmp/include/mach/gpio.h:12,
> ? ? ? ? ? ? ? ? from /home/zhangwm/Public/linux-3.0/arch/arm/include/asm/gpio.h:5,
> ? ? ? ? ? ? ? ? from include/linux/gpio.h:30,
> ? ? ? ? ? ? ? ? from arch/arm/mach-mmp/tavorevb.c:10:
> arch/arm/plat-pxa/include/plat/gpio.h: In function 'gpio_get_value':
> arch/arm/plat-pxa/include/plat/gpio.h:12: error: invalid operands to
> binary & (have 'void *' and 'int')
> arch/arm/plat-pxa/include/plat/gpio.h: In function 'gpio_set_value':
> arch/arm/plat-pxa/include/plat/gpio.h:21: error: lvalue required as left
> operand of assignment
> arch/arm/plat-pxa/include/plat/gpio.h:23: error: lvalue required as left
> operand of assignment
> make[1]: *** [arch/arm/mach-mmp/tavorevb.o] Error 1
> make: *** [arch/arm/mach-mmp] Error 2
>
> Signed-off-by: Neil Zhang <zhangwm@marvell.com>

This bug is already fixed. So this patch is unnecessary.

Thanks
Haojian
