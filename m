From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jan 2016 17:47:52 -0500
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <56992D16.6070800@arm.com>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej> <56990C40.4050407@codeaurora.org>
 <20160115152257.GK3262@leverpostej> <56992987.5080603@codeaurora.org>
 <56992D16.6070800@arm.com>
Message-ID: <56997718.70707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2016 12:32 PM, Marc Zyngier wrote:
>>> Do you have a link to that? Seeing it would help to ease my concerns.
>> > 
>> > The QEMU driver has not been posted yet. As far as I know, it just discovers the memory
>> > resources on the platform object and creates mappings for the guest machine only. 
>> > 
>> > Shanker Donthineni and Vikram Sethi will post the QEMU patch later.
> Then may I suggest you both synchronize your submissions? I'd really
> like to hear from the QEMU maintainers that they are satisfied with that
> side of the story as well.

The HIDMA QEMU driver is also based on VFIO platform driver in QEMU. It is not a new concept
or new framework. All tried and tested solutions. 

The driver below is already using this feature. HIDMA is no exception. 
I have verified functionality of HIDMA linux driver with HIDMA QEMU driver already.

https://lxr.missinglinkelectronics.com/qemu/hw/arm/sysbus-fdt.c#L67
https://lxr.missinglinkelectronics.com/qemu/hw/vfio/calxeda-xgmac.c#L18
https://lxr.missinglinkelectronics.com/qemu/include/hw/vfio/vfio-calxeda-xgmac.h 



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
