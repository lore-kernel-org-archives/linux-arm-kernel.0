From: liu.h.jason@gmail.com (Jason Liu)
Date: Tue, 15 Mar 2011 10:21:26 +0800
Subject: [PATCH] arm/dt: Add dtb make rule
In-Reply-To: <4D7EA61D.4030403@gmail.com>
References: <1299786381-8925-1-git-send-email-robherring2@gmail.com>
	<4D7EA61D.4030403@gmail.com>
Message-ID: <AANLkTin8AoX23GkkVTe1OFLcyx72Fpb6Vfgf=Q4Pes2V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/15 Rob Herring <robherring2@gmail.com>:
> Grant,
>
> On 03/10/2011 01:46 PM, Rob Herring wrote:
>>
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> Add a make rule to compile dt blobs for ARM.
>>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>
> Can you pick this one up in your ARM tree.

Test result on i.MX51 babbage board:

gcl/linux-2.6$ make babbage.dtb  ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
DTC     arch/arm/boot/babbage.dtb
DTC: dts->dtb  on file "arch/arm/boot/dts/babbage.dts"


Tested-by: Jason Liu <jason.hui@linaro.org>

Jason

>
> Rob
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
