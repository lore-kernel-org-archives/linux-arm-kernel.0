From: csd@broadcom.com (Christian Daudt)
Date: Tue, 13 Nov 2012 09:58:13 -0800
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <20121112151720.GG28327@n2100.arm.linux.org.uk>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <20121112151720.GG28327@n2100.arm.linux.org.uk>
Message-ID: <50A28A35.8090003@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-11-12 07:17 AM, Russell King - ARM Linux wrote:
> On Sun, Nov 11, 2012 at 06:57:14AM -0800, Christian Daudt wrote:
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <asm/io.h>
> Please use linux/io.h rather than asm/io.h throughout your patch sets.
> However, I don't see anything in this file which requires this header,
> so it's better off being removed entirely.
>
that will be required later, but you're right. It is not being used at 
this point so I've removed it.
  thanks,
    csd
