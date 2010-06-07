From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 07 Jun 2010 10:47:05 +0200
Subject: [PATCH] RTC/pxa: remove unnecessary private ops->ioctl()
In-Reply-To: <4C0A5F53.6070600@gmail.com> (Wan ZongShun's message of "Sat, 05
	Jun 2010 22:29:39 +0800")
References: <4C0A5F53.6070600@gmail.com>
Message-ID: <877hmbcjqu.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun <mcuos.com@gmail.com> writes:
> Please, do not implement private ops->ioctl() unless absolutely necessary.
> pxa series RTC driver's ioctl() is unnecessary, since RTC subsystem has implement
> the ioctl() very well,so we can only use the API of '.alarm_irq_enable' and
> '.update_irq_enable' to do enable irq action.
>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

This is not an urgent fix, but a cleanup. Whoever gets it in (Alessandro through
rtc tree, Eric through arm/pxa tree, or Andrew) is to be defined.

I would go for Alessandro, as he handles the RTC tree.

Cheers.

--
Robert

PS: Removed alsa-devel list, as this is not alsa material
