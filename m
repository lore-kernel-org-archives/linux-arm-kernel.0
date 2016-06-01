From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Jun 2016 11:10:49 -0700
Subject: [2/3] hwmon: xgene: Adds hwmon driver
In-Reply-To: <CAFHUOYzWj_PbbpzCW5CjO7d3uc7x2h8UvHrYmDoKyttNQVDDZA@mail.gmail.com>
References: <1463415447-29903-3-git-send-email-hotran@apm.com>
 <20160530052507.GA25641@roeck-us.net>
 <CAFHUOYzWj_PbbpzCW5CjO7d3uc7x2h8UvHrYmDoKyttNQVDDZA@mail.gmail.com>
Message-ID: <20160601181049.GA10954@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 11:00:05PM -0700, Hoan Tran wrote:
> Hi Guenter,
> 
> >
> > Overall, I have to say that the code is quite complex due to the repeated
> > checks for ACPI. I am close to suggest having two separate drivers,
> > one for ACPI and one for non-ACPI. Any chance to separate ACPI vs. non-ACPI
> > code a bit better ?
> 
> How about create separate rx_cb functions for ACPI and non-ACPI ?

Yes, that would be great if it is possible.

> As almost functions are the same between ACPI and non-ACPI, I thought
> keep the same driver is still OK, isn't it ?
> 
If you can separate the ACPI code from the non-ACPI code a bit better than
right now, yes.

Thanks,
Guenter
