From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 22 May 2018 21:19:39 +0200
Subject: [PATCH 1/2] ARM: pxa: dts: add gpio-ranges to gpio controller
In-Reply-To: <20180521220044.821-1-daniel@zonque.org> (Daniel Mack's message
 of "Tue, 22 May 2018 00:00:43 +0200")
References: <20180521220044.821-1-daniel@zonque.org>
Message-ID: <87y3gbxzuc.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The PXA GPIO driver calls out to the pinctrl driver for claiming pins
> unless the config has CONFIG_PINCTRL unset. IOW, if a pinctrl driver is
> active, it must be visible to the GPIO driver.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/dt, thanks.

Cheers.

--
Robert
