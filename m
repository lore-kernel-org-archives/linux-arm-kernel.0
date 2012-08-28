From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Aug 2012 16:12:45 -0700
Subject: [PATCH 0/3] Removal of obsolete s3c2410_* GPIO API
In-Reply-To: <CACRpkdaspHBDUjwf_bPtZoFeYK7q97oX4Jat=pmX810RtGJOpA@mail.gmail.com>
References: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
 <CACRpkdaspHBDUjwf_bPtZoFeYK7q97oX4Jat=pmX810RtGJOpA@mail.gmail.com>
Message-ID: <503D506D.9090201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/12 17:13, Linus Walleij wrote:
> On Sat, Aug 25, 2012 at 5:20 AM, Sylwester Nawrocki
> <sylvester.nawrocki@gmail.com>  wrote:
>
>> This short patch series converts remaining users of the s3c24xx SoC
>> specific gpiolib functions to the gpiolib API and finally removes
>> all s3c2410_* functions from drivers/gpio/gpio-samsung.c.
>
> I'm fine with this as long as the Samsung maintainer is, so
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
Thanks, applied this series with your ack.

> But I suspect this will be merged through the Samsung SoC tree?
>
Yes, then will be sent to upstream via arm-soc. If any problems, please 
let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
