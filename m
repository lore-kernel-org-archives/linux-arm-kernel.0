From: balajitk@ti.com (Balaji T K)
Date: Fri, 18 Oct 2013 21:29:16 +0530
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <20131018153541.GJ15154@atomide.com>
References: <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
 <CACRpkdYJNaiAAHhYatd6g5_wVt0QEUxOvsk6nQn9o=_i5zfWrA@mail.gmail.com>
 <20131011154352.GO29913@atomide.com>
 <CACRpkdZhbadd5d4P+2B0_DktqK4CHzZPVJC8kPHZYUnp8TaxsA@mail.gmail.com>
 <20131011160146.GR29913@atomide.com> <5260E606.2030903@ti.com>
 <20131018153541.GJ15154@atomide.com>
Message-ID: <52615AD4.7040306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 October 2013 09:05 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131018 00:41]:
>>
>> Any conclusion on using regmap for omap control module non-mux registers ?
>
> I don't think anybody has even started looking into a SCM driver
> yet considering there are tons of other issues to sort out.
>
> If you're thinking about implementing the MMC PBIAS driver, I would
> just implement it as a standalone driver. It seems that the PBIAS
> interface to the MMC driver can be just regulator framework.
>
Hi Tony,

I am testing pbias regulator, Just thinking whether it should be
using regmap api or direct readl/writel


> Then when we have the SCM driver available, this driver can be
> updated to coordinate things with the core SCM driver.

Do you see regmap getting used for the SCM driver ?

Thanks and Regards,
Balaji T K

>
> Regards,
>
> Tony
>
