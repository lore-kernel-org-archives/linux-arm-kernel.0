From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 3 Feb 2016 22:41:15 +0100
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

> +       port->irq        = irq->start;
> +       port->irqflags   = 0;

Same request as for v1, which you must have overlooked:
port->irqflags = IRQF_SHARED;

Best regards,
Marcin
