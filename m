From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 25 Oct 2011 15:13:14 +0800
Subject: [PATCH v5 00/11] change gpio as platform driver
In-Reply-To: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CAN1soZzVxYgG2pnd=Eafa__P7axvo19OMN3TbV14ULVkt+treA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 9:35 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Changelog
> v5:
> ? ? ?1. use generic gpio driver. So clean gpio-pxa.h and gpio-pxa.c again.
> v4:
> ? ? ?1. append one patch for clean gpio macros and use function instead.
> v3:
> ? ? ?1. Rebase on Russell's for-next branch.
> ? ? ?2. Add clock support.
> ? ? ?3. Move gpio edge detection initiliaztion of arch-mmp into gpio driver.
>
> v2:
> ? ? 1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
> ? ? 2. Remove init function in gpio.c. Move the platfrom_device_register()
> ? ? ? ?into platform driver.
> ? ? 3. Initialize pxa_gpio_regs in gpio-pxa.c
> ? ? 4. Simplify code of identifing pxa gpio series or mmp gpio series.
> ? ? 5. Use linux/io.h instead of asm/io.h.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Any comments?
