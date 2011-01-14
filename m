From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 14 Jan 2011 22:27:15 +0800
Subject: [PATCH 2/2] arm: mx50_rdp: add i2c bus support
In-Reply-To: <1294988137-24654-2-git-send-email-richard.zhao@freescale.com>
References: <1294988137-24654-1-git-send-email-richard.zhao@freescale.com>
	<1294988137-24654-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <AANLkTik2fL=viMrd=va0VwwNEJzk=hwkPVgFwcqhf5m0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Richard,

2011/1/14 Richard Zhao <richard.zhao@freescale.com>:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
> ?arch/arm/mach-mx5/board-mx50_rdp.c ? ? ? ? ? | ? ?7 +++++++
> ?arch/arm/mach-mx5/devices-mx50.h ? ? ? ? ? ? | ? ?3 +++

We need align the naming convention with i.mx53/i.mx50 fordevices-mx50.h ,
I have send out one patch for it.It seems not good when using devices-mx50.h
while using devices-imx53 and devices-imx51.h in the same directory.

I think we need use imx as much as possible since i.mx is FSL chip brand name.

Sascha, please help merge the following patch if you don't have some
comments about it.
http://lists.arm.linux.org.uk/lurker/message/20110110.223149.e2d1fe51.en.html

BR,
Jason

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
