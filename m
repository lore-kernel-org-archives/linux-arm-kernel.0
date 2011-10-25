From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 25 Oct 2011 22:37:28 +0800
Subject: [PATCH] ARM: pxa/cm-x300: properly set bt_reset pin
In-Reply-To: <4EA6C810.30605@compulab.co.il>
References: <1316268934.16763.2.camel@phoenix>
	<4E7B0E35.5010607@compulab.co.il>
	<CAF+7xW=AFmxCmppmt81pzkDbem=LAHdSYtT67yOOzMNPFRpnfA@mail.gmail.com>
	<4E9C4DAE.7020804@compulab.co.il> <4EA6C810.30605@compulab.co.il>
Message-ID: <CAMPhdO9-Y_Y8SoidmMYuuEUOZB0310_2ip0+XjEAhR3P2XWY9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry x 3

Missed this, queued now.

On Tue, Oct 25, 2011 at 10:30 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> ping x2
>
> On 10/17/2011 05:45 PM, Igor Grinberg wrote:
>> ping
>>
>> On 09/29/11 10:57, Axel Lin wrote:
>>> 2011/9/22 Igor Grinberg <grinberg@compulab.co.il>:
>>>> Hi Axel,
>>>>
>>>> On 09/17/11 17:15, Axel Lin wrote:
>>>>> Fix below build warning and properly set bt_reset pin.
>>>>>
>>>>> ? CC ? ? ?arch/arm/mach-pxa/cm-x300.o
>>>>> arch/arm/mach-pxa/cm-x300.c: In function 'cm_x300_init_wi2wi':
>>>>> arch/arm/mach-pxa/cm-x300.c:779: warning: unused variable 'wlan_en'
>>>>> arch/arm/mach-pxa/cm-x300.c:795: warning: 'bt_reset' may be used uninitialized in this function
>>>> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
>>>>
>>>> Also, this patch fixes a real regression since
>>>> 5a009df1f200efa49658b0e9c7ad056d59fbefe4 (ARM: pxa/cm-x300: GPIO cleanup)
>>>> - Wifi and Bluetooth do not work without it, so please:
>>>>
>>>> Cc: <stable@kernel.org> [3.0.x]
>>>>
>>> Hi, Eric,
>>> Just to pin the status of this patch. I think it should go for 3.1.
>>> Thanks,
>>> Axel
>>>
>
>
