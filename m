From: jason77.wang@gmail.com (jason wang)
Date: Wed, 2 Jun 2010 21:55:25 +0800
Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and
	registration
References: <495250.54370.qm@web51001.mail.re2.yahoo.com>
Message-ID: <002201cb025b$48bc71a0$9b00a8c0@wuef10f27ebed8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Jason,
> 
> --- On Tue, 6/1/10, Jason Wang <jason77.wang@gmail.com> wrote:
> 
>> From: Jason Wang <jason77.wang@gmail.com>
>> Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and registration
>> To: s.hauer at pengutronix.de, amit.kucheria at canonical.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Date: Tuesday, June 1, 2010, 12:10 PM
>> On i.MX51 platforms, the keypad
>> controller has no gate clock, to
>> meet the imx keypad driver requirement, we add a empty
>> definition and
>> register it. Now the keypad driver can work.
> 
> I did not see an entry for the keypad at arch/arm/mach-mx5/devices.c.
> 
I placed the keypad device definition in the board-mx51_3ds.c, i will move it in the devices.c in V2.

Thanks,
Jason.

> Regards,
> 
> Fabio Estevam
> 
> 
>
