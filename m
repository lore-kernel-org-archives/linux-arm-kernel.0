From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Apr 2011 19:36:27 +0100
Subject: [PATCH 9/9] ARM: mmp: enable max7312 gpio expander in dkb
In-Reply-To: <1301625568-16583-9-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-8-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-9-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110401183627.GD8482@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 10:39:28AM +0800, Haojian Zhuang wrote:
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/flash.h>
>  #include <mach/addr-map.h>
> +#include <mach/gpio.h>

linux/gpio.h
