From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 31 May 2016 12:51:05 +0300
Subject: interrupts properties and API usage with GPIO controllers/Device
 Tree
In-Reply-To: <CACRpkdYULz6fgw8N_yLCGYzqV7DjeJGmh1b0e9coxpGqSgZf+A@mail.gmail.com>
References: <57461CDC.603@gmail.com> <57485844.3050807@ti.com>
 <CACRpkdYULz6fgw8N_yLCGYzqV7DjeJGmh1b0e9coxpGqSgZf+A@mail.gmail.com>
Message-ID: <574D5E89.10906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 11:49 AM, Linus Walleij wrote:
> On Fri, May 27, 2016 at 4:23 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>
>> Another interesting, related question (as for me) is "Is there a limitation
>>   that gpio bank can have only 32 GPIO pins (from gpiolib point of view)?"
>
> Do you mean for this driver or in general?

In general.

>
> The gpio MMIO driver has this limitation, but not the subsystem
> and gpiolib as far as I know.

Thanks.

-- 
regards,
-grygorii
