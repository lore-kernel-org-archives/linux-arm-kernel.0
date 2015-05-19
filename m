From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 19 May 2015 08:00:04 +0200
Subject: mach-pxa/pxa_cplds_irqs.c:126: bad if test ?
In-Reply-To: <DUB128-W342054A60A9EB2505BCA469CC40@phx.gbl> (David Binderman's
 message of "Mon, 18 May 2015 21:44:30 +0000")
References: <DUB128-W342054A60A9EB2505BCA469CC40@phx.gbl>
Message-ID: <87382tjee3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Binderman <dcb314@hotmail.com> writes:

> Hello there,
>
> [linux-4.1-rc4/arch/arm/mach-pxa/pxa_cplds_irqs.c:126]: (style) Checking if
> unsigned variable 'base_irq' is less than zero.
>
> ??? base_irq = platform_get_irq(pdev, 1);
> ??? if (base_irq < 0)
> ??????? base_irq = 0;
Thanks David, a patch has already been provided by Dan Carpenter.

Cheers.

--
Robert
