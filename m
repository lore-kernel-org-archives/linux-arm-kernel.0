From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 19 Mar 2012 15:01:41 +1000
Subject: Atmel at91x40 ("EB01" eval board) resurected
In-Reply-To: <20120317164345.4f20beef@skate>
References: <CALz2mmXcAk9ZOsAzKMbKVVJ2+Et02+Gxj_z6xSgukC5LjgJTLg@mail.gmail.com>
 <20120317164345.4f20beef@skate>
Message-ID: <4F66BDB5.5020600@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 18/03/12 01:43, Thomas Petazzoni wrote:
> Le Thu, 22 Dec 2011 22:18:53 -0500,
> Phil Budne<phil@ultimate.com>  a ??crit :
>
>> I decided to see if I could bring up current kernel sources under
>> skyeye  (at91x40 simulation).
>
> Very interesting, thanks. Your patches indeed allow the AT91x40 kernel
> to boot under SkyEye, while the unpatched Linux kernel does not,
> apparently.
>
> Greg, it seems you are saying that the mainline kernel, unchanged,
> boots under SkyEye.

No, I didn't mean to imply that in my response (
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/078670.html).
It has worked in the past, but I haven't run it for a few kernel
versions now.

I was hoping that Phil would respond to the couple of questions I
had about differences, but he never did.


> Could you share your kernel configuration and
> SkyEye configuration?

Yeah, its in mainline. Its one of the defconfigs:

   arch/arm/configs/at91x40_defconfig
   

>> Runs on locally modified skyeye
>>   based on skyeye-v1.2_Rel.tar (had trouble building latest release)
>>   adds interrupt driven UART output
>>   tweaked for programmed I/O UART input
>>   fix for loading XIP data section (load at physical, not virtual address)
>
> Would you mind publishing your changes to SkyEye? So far, I'm blocked
> because of the lack of interrupt driver UART output.
>
> Do you plan on further pushing those AT91x40 changes?

It would be really nice to get Phil's changes in a form that can be
applied to mainline.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
