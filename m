From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 3 Jan 2018 12:19:02 +0100
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <20180103111611.GB21230@xora-haswell>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
 <20180103111611.GB21230@xora-haswell>
Message-ID: <CAPv3WKchh4CHS7x0T_9vJ++=ONK5vtLh8oRN_7fgq0uPH29jwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Graeme,

2018-01-03 12:16 GMT+01:00  <graeme.gregory@linaro.org>:
> On Sun, Dec 31, 2017 at 08:23:54PM +0100, Andrew Lunn wrote:
>> > * Modify way of obtaining interrupts - with ACPI they are resources
>> >   bound to struct platform_device and it's not possible to obtain
>> >   them directly from the child node. Hence a formula is used, depending
>> >   on the port_id and number of possible CPUs.
>>
>> Hi Marcin
>>
>> I know nothing about ACPI. Is this limitation with respect to
>> interrupts fundamental to ACPI, or just that nobody has implemented
>> flexible interrupt support yet?
>>
> The infrastructure is there to traverse trees of children, but I don't
> think there any helper functions.
>

Thanks, so if I implement such, do you expect any formal issues that
prevent its acceptance?

Best regards,
Marcin
