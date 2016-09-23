From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 23 Sep 2016 13:09:12 +0530
Subject: [PATCH v2] arm: dts: zynq: Add MicroZed board support
In-Reply-To: <4a586da6-8d94-bfbe-ea0c-58b6f8573e7b@xilinx.com>
References: <1474550489-7005-1-git-send-email-jagan@amarulasolutions.com>
 <20160922205917.GS16583@xsjsorenbubuntu>
 <4a586da6-8d94-bfbe-ea0c-58b6f8573e7b@xilinx.com>
Message-ID: <CAD6G_RR6JSzd-QCUj3wDC30pXabNqaNR1d1jQm9bUq6z0CP=3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 11:33 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 22.9.2016 22:59, S?ren Brinkmann wrote:
>> On Thu, 2016-09-22 at 18:51:29 +0530, Jagan Teki wrote:
>>> From: Jagan Teki <jteki@openedev.com>
>>>
>>> Added basic dts support for MicroZed board.
>>>
>>> - UART
>>> - SDHCI
>>> - Ethernet
>>>
>>> Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Signed-off-by: Jagan Teki <jteki@openedev.com>
>>> ---
>>> Changes for v2:
>>>      - Add SDHCI
>>>      - Add Ethernet
>>>
>>>  arch/arm/boot/dts/Makefile          |  1 +
>>>  arch/arm/boot/dts/zynq-microzed.dts | 95 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 96 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/zynq-microzed.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index faacd52..4d7b858 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -862,6 +862,7 @@ dtb-$(CONFIG_ARCH_VT8500) += \
>>>      wm8750-apc8750.dtb \
>>>      wm8850-w70v2.dtb
>>>  dtb-$(CONFIG_ARCH_ZYNQ) += \
>>> +    zynq-microzed.dtb \
>>>      zynq-parallella.dtb \
>>>      zynq-zc702.dtb \
>>>      zynq-zc706.dtb \
>>> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
>>> new file mode 100644
>>> index 0000000..9e64496
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/zynq-microzed.dts
>>> @@ -0,0 +1,95 @@
>>> +/*
>>> + * Copyright (C) 2015 Jagan Teki <jteki@openedev.com>
>
>
> Did you created only yourself without copying part of this from others?
> There is dts in u-boot which I believe you are aware of.

I sent the initial one few months back so at that time, I was created
and now I just added USB and Ethernet with the reference of zc702
board.

thanks!
-- 
Jagan.
