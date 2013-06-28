From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Jun 2013 10:11:12 -0300
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803EFF788@039-SN2MPN1-023.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com> <201306281142.51676.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF551@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306281356.51670.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF788@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <CAOMZO5AW1jcjVqEyh=qP3kQK75dZvpOY+BYcKGiymfJPLa94ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 10:04 AM, Chen Peter-B29397
<B29397@freescale.com> wrote:
>
>
>> >
>> > Just measure the voltage of your otg vbus pin.
>>
>> Ok, I see it's 2.25 volts after I disconnect the microB-A thing . I
>> should see
>> 0.8V constantly with nothing connected on the port?
>>
>
> You should see the voltage of vbus pin is less than 0.8v when
> nothing is connected, we use B_SESSION_VALID (0.8v) to judge
> it is connected or not.
>
> You get 2.25 all the time or it is discharged very slowly?

On my mx28evk it discharges very very slowly. Any hints about it?

Thanks
