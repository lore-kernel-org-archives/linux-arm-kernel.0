From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 22 May 2012 13:24:57 +0300
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <878vgkbjie.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Richard Zhao <richard.zhao@freescale.com> writes:
>
>> +#include "ci.h"
>> +
>> +#define PORT0_STATUS	0x184
>
> This doesn't seem to be used anywhere.

Please disregard this one.

Regards,
--
Alex
