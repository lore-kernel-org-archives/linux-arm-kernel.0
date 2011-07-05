From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:14:07 +0800
Subject: [PATCH 9/9] ARM: mmp: enable max7312 gpio expander in dkb
In-Reply-To: <20110401183627.GD8482@n2100.arm.linux.org.uk>
References: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-8-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-9-git-send-email-haojian.zhuang@marvell.com>
	<20110401183627.GD8482@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO8KG2NC48oRifbiT3a8Lv-ZBo3k1QCpNPx3i8O7ypJp+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2011 at 2:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 01, 2011 at 10:39:28AM +0800, Haojian Zhuang wrote:
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> ?#include <asm/mach/flash.h>
>> ?#include <mach/addr-map.h>
>> +#include <mach/gpio.h>
>
> linux/gpio.h
>

Applied with the above change.
