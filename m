From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 28 Jul 2010 12:48:00 +0800
Subject: [rtc-linux] [PATCH v2 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <007901cb2e0d$ac1faa40$045efec0$%kim@samsung.com>
References: <1280235553-27369-1-git-send-email-kgene.kim@samsung.com>
	<20100727194611.04486f92@linux.lan.towertech.it>
	<007901cb2e0d$ac1faa40$045efec0$%kim@samsung.com>
Message-ID: <AANLkTikE-2daOEX9G+t2E3ywiM=4E0L4TYBw=S2fftTY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/28 Kukjin Kim <kgene.kim@samsung.com>:
> Alessandro Zummo wrote:
>>
>> On Tue, 27 Jul 2010 21:59:13 +0900
>> Kukjin Kim <kgene.kim@samsung.com> wrote:
>>
>> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
>> >
>> > RTC needs to be initialized when BCD registers have invalid value.
>> >
>> > Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>
>>
>> ?Acked-by: Alessandro Zummo <a.zummo@towertech.it>
>>
> Thanks for your ack.
>
> So...which subsystem tree is appropriate for this?

S3c git tree or Andrew's mm git tree.

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



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
