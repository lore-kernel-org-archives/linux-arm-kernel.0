From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Oct 2016 11:31:51 +0200
Subject: [PATCH] ARM: dts: pxa: fix gpio0 and gpio1 interrupts
In-Reply-To: <1474874531-26703-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 26 Sep 2016 09:22:11 +0200")
References: <1474874531-26703-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <8760p389vc.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Since gpio-pxa was redesigned to differenciate gpio0, gpio1 and the
> gpio-mux interrupt as in the hardware IP, the device-tree description
> should be amended so that interrupts from gpio0 and gpio1 can be mapped
> to consumers.
>
> This is especially true on lubbock and mainstone devices where gpio0 is
> multiplexed on pxa_cplds for ethernet, sa1111, usb udc, and other
> devices.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Applied to pxa/dt.

Cheers.

-- 
Robert
