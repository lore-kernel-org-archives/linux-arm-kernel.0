From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 Dec 2009 20:54:36 -0500
Subject: [patch 4/4] [ARM] mmp: support flint development board
In-Reply-To: <20091207145515.GE19348@n2100.arm.linux.org.uk>
References: <771cded00912062220u4cce8ccdy5a61fbe356c394cc@mail.gmail.com>
	<20091207120553.GC19348@n2100.arm.linux.org.uk>
	<771cded00912070434m74ba2154h6b7c51581b0d4474@mail.gmail.com>
	<20091207145515.GE19348@n2100.arm.linux.org.uk>
Message-ID: <771cded00912071754o24cafe68x119117010b553fed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2009 at 9:55 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 07, 2009 at 07:34:07AM -0500, Haojian Zhuang wrote:
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smc91x.h>
>> +#include <linux/io.h>
>> +#include <linux/gpio.h>
>
> Good.
>
>> +
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <mach/addr-map.h>
>> +#include <mach/gpio.h>
>
> Bad.
>

Thanks a lot. Fixed it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004--ARM-mmp-support-flint-development-board.patch
Type: text/x-patch
Size: 3984 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091207/1d20323c/attachment.bin>
