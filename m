From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 20 Jul 2013 23:34:29 +0200
Subject: [PATCH v9] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <CACRpkdYktthfRsn9=9GjphXUbOEAswdCZCM48KFK2WRgBdj-Qw@mail.gmail.com>
References: <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
 <1374048297-4321-1-git-send-email-jonas.jensen@gmail.com>
 <CACRpkdYktthfRsn9=9GjphXUbOEAswdCZCM48KFK2WRgBdj-Qw@mail.gmail.com>
Message-ID: <51EB0265.2030508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2013 10:45 PM, Linus Walleij wrote:
> On Wed, Jul 17, 2013 at 10:04 AM, Jonas Jensen <jonas.jensen@gmail.com> wrote:
> 
>> +#include <linux/clk.h>
>> +#include <linux/clockchips.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/io.h>
>> +#include <linux/clocksource.h>
> 
> #include <linux/bitops.h>
> 
>> +#define TIMEREG_CR_1_ENABLE    BIT(0)
> 
> Because BIT() comes from there. And we shall not rely on
> implicit #inclusion.

Hi Jonas,

as the patchset is already merged could you fix it with a separate patch ?

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
