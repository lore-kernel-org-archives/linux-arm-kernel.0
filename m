From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 12 Mar 2013 16:57:06 +0900
Subject: [PATCH 04/04] ARM: shmobile: APE6EVM support
In-Reply-To: <87li9trr7l.wl%kuninori.morimoto.gx@renesas.com>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045637.19701.62477.sendpatchset@w520>
 <87li9trr7l.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CANqRtoTSXBPo6-MksuXtfHVwEDTqEGdKg0tczJKriCuFW9mnzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 4:51 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus
>
> I already sent Reviewed-by, but...
>
>> @@ -0,0 +1,40 @@
>> +/*
>> + * APE6EVM board support
>> + *
>> + * Copyright (C) 2013  Renesas Solutions Corp.
>> + * Copyright (C) 2013  Magnus Damm
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/irqchip.h>
>> +#include <mach/common.h>
>> +#include <mach/r8a73a4.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>
> There are too many include here,
> and not in alphabetical order :)

Yes. And what's next? Do I need to encode using Shift-JIS? =)

/ magnus
