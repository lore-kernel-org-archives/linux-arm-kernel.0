From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 3 Feb 2016 23:02:24 +0100
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
Message-ID: <20160203230224.5ea52f65@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Wed, 3 Feb 2016 22:41:15 +0100, Marcin Wojtas wrote:
> Hi Gregory,
> 
> > +       port->irq        = irq->start;
> > +       port->irqflags   = 0;
> 
> Same request as for v1, which you must have overlooked:
> port->irqflags = IRQF_SHARED;

Gregory didn't overlook this comment you made on v1, he even replied to
it. Please check Gregory's reply to your review.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
