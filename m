From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 3 Feb 2016 23:22:36 +0100
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <20160203230224.5ea52f65@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
 <20160203230224.5ea52f65@free-electrons.com>
Message-ID: <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm sorry, indeed, I was the one to overlook - there was a lot going
on in a thread and I missed it.

Ofer, as you found out that IRQF_SHARED help booting ubuntu - do you
think it's a hack or fix?

Best regards,
Marcin

2016-02-03 23:02 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Wed, 3 Feb 2016 22:41:15 +0100, Marcin Wojtas wrote:
>> Hi Gregory,
>>
>> > +       port->irq        = irq->start;
>> > +       port->irqflags   = 0;
>>
>> Same request as for v1, which you must have overlooked:
>> port->irqflags = IRQF_SHARED;
>
> Gregory didn't overlook this comment you made on v1, he even replied to
> it. Please check Gregory's reply to your review.
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
