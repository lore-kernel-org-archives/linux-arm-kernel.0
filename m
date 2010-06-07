From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 7 Jun 2010 16:57:32 +0800
Subject: [PATCH] RTC/pxa: remove unnecessary private ops->ioctl()
In-Reply-To: <877hmbcjqu.fsf@free.fr>
References: <4C0A5F53.6070600@gmail.com>
	<877hmbcjqu.fsf@free.fr>
Message-ID: <AANLkTilJntnk11OZJt5oeKv4bk5qv8nlDnuGHc2hTGOt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/7 Robert Jarzmik <robert.jarzmik@free.fr>:
> Wan ZongShun <mcuos.com@gmail.com> writes:
>> Please, do not implement private ops->ioctl() unless absolutely necessary.
>> pxa series RTC driver's ioctl() is unnecessary, since RTC subsystem has implement
>> the ioctl() very well,so we can only use the API of '.alarm_irq_enable' and
>> '.update_irq_enable' to do enable irq action.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> This is not an urgent fix, but a cleanup. Whoever gets it in (Alessandro through
> rtc tree, Eric through arm/pxa tree, or Andrew) is to be defined.
>

I will ping Andrew to apply it as soon as I get the owner's ACK.

> I would go for Alessandro, as he handles the RTC tree.
>
> Cheers.
>
> --
> Robert
>
> PS: Removed alsa-devel list, as this is not alsa material

Yes, I think I am careless for this. sorry.
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
