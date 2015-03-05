From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Mar 2015 21:01:45 -0800
Subject: [PATCH v9 2/4] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <54F742CA.7080500@broadcom.com>
References: <1423606584-21795-1-git-send-email-rjui@broadcom.com>	<1423606584-21795-3-git-send-email-rjui@broadcom.com>
 <CACRpkda-C1upKfa4FKLcVF9sxL4T=B+eG9ndun4fS6DZ9TfCSw@mail.gmail.com>
 <54F742CA.7080500@broadcom.com>
Message-ID: <54F7E339.50902@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

>>> +#include <linux/kernel.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/module.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/gpio.h>
>>
>> This should be:
>> #include <linux/gpio/driver.h>

In fact, just by trying it out I found I need linux/gpio.h for APIs like
gpiochip_add_pin_range, and etc.

>>
>>
> 
> Great! I will address all comments and re-send a BIG patch series with
> the other pinctrl patch series consolidated.
> 
> Thanks!
> 
> Ray
> 

I've consolidated this patch series with the IOMUX and sent out a
combined patch series earlier. I believe all other comments have been
addressed except the above include header one.

Thanks,

Ray
