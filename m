From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 10 Jun 2015 12:03:47 +0200
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <5577246B.3080602@linaro.org>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
 <20150608224749.GB7557@n2100.arm.linux.org.uk>
 <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
 <5576D0FE.10900@linaro.org>
 <20150609150127.GF7557@n2100.arm.linux.org.uk>
 <5577246B.3080602@linaro.org>
Message-ID: <CALszF6DjQ-3gruP4t4cwTBLv=G=2CSqmE8ZJWc8ED1GaNEA7GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-09 19:37 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 09/06/15 16:01, Russell King - ARM Linux wrote:
>>
>> On Tue, Jun 09, 2015 at 12:41:50PM +0100, Daniel Thompson wrote:
>>>
>>> Does the following patch, which makes the arch_irqs_disabled()
>>> implementation from asm-generic available on arm, fix the build for you?
>>
>>
>> Yes, this is exactly the kind of fix for this I'm looking for.  Once
>> everyone's happy with it, it can find it's way to the patch system.
>
>
> From my side, using v4.1-rc6 plus the patch, I can build all defconfigs and
> both versatile_defconfig and multi_v7_defconfig remain bootable (so both
> ways through the arch #ifdef in irqflag.h).
>
> Similarly working on linux-next-20150608 plus the patch I am able to build
> and boot Maxime's stm32 code (and show that without the patch it doesn't
> build).
Ok, thanks for having tested on STM32.

>
> From my side I think that makes it good to go.
>
> So... in the absense of objections I will send it to the patch tracker
> tomorrow.

For what it is worth, you can add:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Regards,
Maxime
