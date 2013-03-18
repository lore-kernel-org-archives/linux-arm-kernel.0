From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 18 Mar 2013 16:21:55 +0100
Subject: [PATCH V4] ARM: dts: add minimal DT support for DevKit8000.
In-Reply-To: <CABYxbz7bLZxX-6U3O9nRsKxAXbg0nEta55eO-ERuotPnw=X5BQ@mail.gmail.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412CC4E9@DBDE01.ent.ti.com>
 <CABYxbz5GyxYaHANgdpwBNaaR6tnu=6LJuUNSvL7DEzU=4CPHcA@mail.gmail.com>
 <F3DBB1B3EF102E4994C89758CFCA32412CC74F@DBDE01.ent.ti.com>
 <CABYxbz62JrMB95p5i9iu2G=B4ETXLrYbLsyFEFR5F+WVD6YNnQ@mail.gmail.com>
 <20130306175313.GQ11806@atomide.com> <513838F2.60101@ti.com>
 <CABYxbz7bLZxX-6U3O9nRsKxAXbg0nEta55eO-ERuotPnw=X5BQ@mail.gmail.com>
Message-ID: <51473113.9060109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anil,

On 03/17/2013 06:23 AM, Anil Kumar wrote:
> Hi Benoit,
> 
> On Thu, Mar 7, 2013 at 12:21 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Hi,
>>
>> On 03/06/2013 06:53 PM, Tony Lindgren wrote:
>>> * Anil Kumar <anilk4.v@gmail.com> [130305 18:40]:
>>>> Hi Tony,
>>>>
>>>>>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>>>>>> bounces at lists.infradead.org] On Behalf Of Anil Kumar
>>>>>> Sent: Wednesday, February 27, 2013 8:03 AM
>>>>>> To: devicetree-discuss at lists.ozlabs.org; linux-omap at vger.kernel.org;
>>>>>> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>>>>>> Cc: linux at arm.linux.org.uk; Cousson, Benoit; Tony Lindgren; Grant
>>>>>> Likely; Anil Kumar; thomas at tomweber.eu
>>>>>> Subject: Re: FW: [PATCH V4] ARM: dts: add minimal DT support for
>>>>>> DevKit8000.
>>>>>>
>>>>>> Hi,
>>>>>>>
>>>>>>> DevKit8000 is a beagle board clone from Timll, sold by
>>>>>>> armkits.com. The DevKit8000 has RS232 serial port, LCD, DVI-D,
>>>>>>> S-Video, Ethernet, SD/MMC, keyboard, camera, SPI, I2C, USB and
>>>>>>> JTAG interface.
>>>>>>>
>>>>>>> This patch adds the basic DT support for devkit8000. At this time,
>>>>>> Information
>>>>>>> of twl4030 (PMIC), MMC1, I2C1 and leds are added.
>>>>>>>
>>>>>>> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
>>>>>>> Tested-by: Thomas Weber <thomas@tomweber.eu>
>>>>>>
>>>>>> Gentle Ping. As there are no review comments on this patch,
>>>>>> Could you please pull this patch ?
>>>>
>>>> Gentle Ping.
>>>>
>>>> This patch also got Reviewed-by: Manish Badarkhe <badarkhe.manish@gmail.com>
>>>> and as patch "ARM: dts: omap3-devkit8000: Enable audio support"  has already got
>>>> "Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>" but it is on the
>>>> top of this patch.
>>>> So, Could you please pull this patch in one of your omap branch? or
>>>> you want me to
>>>> do rebase this patch on top of v3.9-rc1 ?
>>>
>>> Let's wait for Benoit to queue it as he has a bunch of .dts changesfor_3.10/dts already
>>> applied. Too bad we missed v3.9 merge window for those, but hopefully
>>> we can get them queued early for v3.10.
>>
>> Yep, sorry for having missed 3.9, I was a little bit sick at the wrong
>> moment :-(
>>
>> I'm starting queuing the pending patches, and should have enough to push
>> to you just after Linaro Connect.
> 
> I think you missed below patch which is needed for gpmc nand to work fine.
> 
> Jon Hunter:-
>   ARM: OMAP2+: Fix-up gpmc merge error
> 
> I have re based my changes on top of your repository to make pull
> easier for you.
> I hope you will pull these changes for 3.10.
> 
> The following changes since Commit a7f7881de9c0b58de3b3aea8f01a8aef906d4ade
> 
> are available in the git repository at:
> 
> git://gitorious.org/devkit8000-for_3-10/devkit8000-for_3-10.git
> branch for_3.10/dts
> 
> for you to fetch changes up to Commit 975abc8b2e7ec4ff7324d726c9775958945ccc5e

Thanks, I pulled the patches and rebased that on top of -rc3 to get the
missing fix from Jon.

I cleaned as well some changelog / subject and pushed then in my
for_3.10/dts branch.

Regards,
Benoit
