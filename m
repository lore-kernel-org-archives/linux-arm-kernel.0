From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Wed, 25 Nov 2009 08:52:08 -0200
Subject: [PATCH v2] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <c70ff3ad0911241139g2b5b706fp936a009867ac7674@mail.gmail.com>
References: <37367b3a0911241021u68ac346dmf30fc98f252b1d35@mail.gmail.com>
	<c70ff3ad0911241139g2b5b706fp936a009867ac7674@mail.gmail.com>
Message-ID: <37367b3a0911250252h746c2166n4eef27cf1046fbbe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saeed,

On 11/24/09, saeed bishara <saeed.bishara@gmail.com> wrote:
>> ...
>> +#include <mach/i2c.h>
>> +#include <mach/imxfb.h>
>> +#include <mach/mmc.h>
>> +
>> +#include "devices.h"
>> +
>> +static unsigned int mxt_td60_pins[] = {
> shouldn't this be __initdata?

I think it could be used, but I don't see others MX27 boards using it.

Sascha, what you think?

Regards,

Alan
