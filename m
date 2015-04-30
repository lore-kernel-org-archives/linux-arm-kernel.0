From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Apr 2015 15:14:58 +0100
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <20150430141152.GG15254@pengutronix.de>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
 <20150429191228.GO15254@pengutronix.de>
 <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
 <20150430133011.GE15254@pengutronix.de> <55423316.70408@arm.com>
 <20150430141152.GG15254@pengutronix.de>
Message-ID: <554238E2.9090405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/04/15 15:11, Robert Schwebel wrote:
> On Thu, Apr 30, 2015 at 02:50:14PM +0100, Sudeep Holla wrote:
>>> [    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
>>> [    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
>>> [    0.268626] platform 10000000.sysreg: Error -2 creating of_node link
>>> [    0.271997] platform basic-mmio-gpio.1.auto: Error -2 creating of_node link
>>> [    0.272266] platform basic-mmio-gpio.2.auto: Error -2 creating of_node link
>>> [    0.272681] platform basic-mmio-gpio.3.auto: Error -2 creating of_node link
>>
>> I see above errors even on my Vexpress TC2, but
>>
>>> [    0.426298] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller at 100e0000
>>> [    0.426799] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller at 100e1000
>>> [    0.427099] of_amba_device_create(): amba_device_add() failed (-19) for /watchdog at 100e5000
>>> [    0.433206] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga at 7,00000000/sysctl at 01000
>>> [    0.438165] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga at 7,00000000/wdt at 0f000
>>>
>> .. not theses ones
>>
>>> Do you have an idea what might go wrong?
>>>
>>
>> I will give it a spin on my CA9 coretile.
>
> I'm testing on qemu (and not even the latest one), so this might be a
> reason.

OK, I tried on my CA9 coretile and don't see these errors on it either.
However the "... creating of_node link" is present on both and I will
look at that issue.

Regards,
Sudeep
