From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Mon, 22 Oct 2012 17:21:13 +0200
Subject: [PATCH 0/4] ARM/dts: Update OMAP5 with address space and
 interrupts
In-Reply-To: <5085541C.5040209@ti.com>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com>
 <5085541C.5040209@ti.com>
Message-ID: <50856469.8080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 10/22/2012 04:11 PM, Benoit Cousson wrote:
> Hi Seb,
>
> Good work. Thanks for that series.
>
> Just update it with all the acked-by you've got from the TI driver folks
> + the minor comment and I'll pull it in the for_3.8/dts branch.
>
> That's a detail but you should update the subject with "ARM: dts: OMAP5:
> XXX" prefix for consistency with the latest naming convention.
Thanks for the information I will update the series. I was thinking that 
it was the convention according to a past talk. I will update our full 
audio/display feature tree with this convention.

>
> Please, Cc the DT list as well.
>
> Regards,
> Benoit
>
> On 10/22/2012 12:22 PM, Sebastien Guiriec wrote:
>> Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
>> and interrupt line description inside dtsi file for OMAP5. This serie is updating the
>> current OMAP5 IP with missing entry.
>>
>> It has been tested on OMAP5 with 3.7-audio-display feature tree.
>> - MMC is probing and functional
>> - TWL6041 probing (GPIO/I2C)
>> - booting (UART)
>>
>> Sebastien Guiriec (4):
>>    ARM/dts: omap5: Update GPIO with address space and interrupt
>>    ARM/dts: omap5: Update I2C with address space and interrupts
>>    ARM/dts: omap5: Update UART with address space and interrupts
>>    ARM/dts: omap5: Update MMC with address space and interrupts
>>
>>   arch/arm/boot/dts/omap5.dtsi |   56 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 52 insertions(+), 4 deletions(-)
>>
>
