From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 17 Mar 2012 16:43:45 +0100
Subject: Atmel at91x40 ("EB01" eval board) resurected
In-Reply-To: <CALz2mmXcAk9ZOsAzKMbKVVJ2+Et02+Gxj_z6xSgukC5LjgJTLg@mail.gmail.com>
References: <CALz2mmXcAk9ZOsAzKMbKVVJ2+Et02+Gxj_z6xSgukC5LjgJTLg@mail.gmail.com>
Message-ID: <20120317164345.4f20beef@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Phil,

Le Thu, 22 Dec 2011 22:18:53 -0500,
Phil Budne <phil@ultimate.com> a ?crit :

> I decided to see if I could bring up current kernel sources under
> skyeye  (at91x40 simulation).

Very interesting, thanks. Your patches indeed allow the AT91x40 kernel
to boot under SkyEye, while the unpatched Linux kernel does not,
apparently.

Greg, it seems you are saying that the mainline kernel, unchanged,
boots under SkyEye. Could you share your kernel configuration and
SkyEye configuration?

> Runs on locally modified skyeye
>  based on skyeye-v1.2_Rel.tar (had trouble building latest release)
>  adds interrupt driven UART output
>  tweaked for programmed I/O UART input
>  fix for loading XIP data section (load at physical, not virtual address)

Would you mind publishing your changes to SkyEye? So far, I'm blocked
because of the lack of interrupt driver UART output.

Do you plan on further pushing those AT91x40 changes?

Thanks for your work,

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
