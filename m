From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Nov 2014 09:18:32 +0100
Subject: [PATCH v2 4/6] phy: add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <5461E169.1040404@ti.com>
References: <1414164254-13053-1-git-send-email-gregory.clement@free-electrons.com>
 <1414164254-13053-5-git-send-email-gregory.clement@free-electrons.com>
 <545899CF.3080001@ti.com> <5461E169.1040404@ti.com>
Message-ID: <546317D8.9010602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
[...]
>>> index 000000000000..cbd2d4e720bb
>>> --- /dev/null
>>> +++ b/include/dt-bindings/phy/armada-375-usb-cluster.h
>>> @@ -0,0 +1,19 @@
>>> +/*
>>> + * Copyright (C) 2014 Marvell
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 of the
>>> + * License, or (at your option) any later version.
>>> + */
>>> +
>>> +#ifndef __ARMADA_375_USB_CLUSTER__
>>> +#define __ARMADA_375_USB_CLUSTER__
>>> +
>>> +/* The supported mode passed through by the phandle are the following */
>>> +
>>> +#define PHY_NONE    0
>>> +#define PHY_USB2    1
>>> +#define PHY_USB3    2
>>
>> Let's not add a separate file for every platform for these generic modes.
> 
> Can you use this patch [1] and resend your series?
> 

Yes sure, a new series is coming soon.

Thanks,

Gregory


> Thanks
> Kishon
> 
> [1] -> http://www.gossamer-threads.com/lists/linux/kernel/2044969
>>
>> Thanks
>> Kishon
>>> +
>>> +#endif /* __DT_BINDINGS_CLOCK_R8A7791_H__ */
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
