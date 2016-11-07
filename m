From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 7 Nov 2016 22:42:34 +0530
Subject: [PATCH 1/6] mfd: max8997: Initialize max8997 register map
In-Reply-To: <1b150578-b766-3470-475c-fe494bcc8c54@osg.samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-2-git-send-email-pankaj.dubey@samsung.com>
 <1b150578-b766-3470-475c-fe494bcc8c54@osg.samsung.com>
Message-ID: <CAGcde9FvWWW4Yc08s9BzPsKrcqvWCj+kOPGp9pN__ssQC0V4tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 7 November 2016 at 19:52, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Pankaj,
>
> On 11/07/2016 07:09 AM, Pankaj Dubey wrote:
>> This patch add regmap initialization to use register map
>> in max8997-clk device driver
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>
> Patch looks good to me. Now that the driver uses regmap, I think you should
> be able to get rid of drivers/mfd/max8997-irq.c and use the regmap IRQ chip
> like is done in most Maxim PMIC MFD drivers.
>
> That can be done as a follow-up of this series though.
>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>

Thanks for review.
You are right, that we can get rid of max8997-irq.c by using regmap
IRQ chip, but I would like to take that as a separate follow-up
series.

Thanks,
Pankaj Dubey

> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
