From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 13 Feb 2014 20:43:15 +0200
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <20140213182105.GN13576@mudshark.cambridge.arm.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
Message-ID: <52FD1243.9040706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13.02.2014 20:21, Will Deacon wrote:
>
> That's certainly unexpected. The n900 has (iirc) a Cortex-A8, which as an
> ARMv7 core, can perform unaligned accesses to normal, cacheable memory in
> hardware.
>

Yep, Cortex-A8 and it has no problem to do unaligned memory accesses 
AFAIK. I suspect it is a driver issue, not CPU.

> Can you provide your .config and/or any information about your network chip
> please? There's a chance that the driver is doing something odd.

The chip is TI wl1251, you can find the config file here(actually this 
is the tree I am using to boot 3.14-rc1 on N900) - 
https://gitorious.org/linux-n900/freemangordons-linux-n900/source/1434dbd7fbc5ec257b6cd6c547689b79177d1937:arch/arm/configs/rx51_defconfig

Thanks,
Ivo
