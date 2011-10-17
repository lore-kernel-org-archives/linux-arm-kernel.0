From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 17 Oct 2011 17:45:50 +0200
Subject: [PATCH] ARM: pxa/cm-x300: properly set bt_reset pin
In-Reply-To: <CAF+7xW=AFmxCmppmt81pzkDbem=LAHdSYtT67yOOzMNPFRpnfA@mail.gmail.com>
References: <1316268934.16763.2.camel@phoenix>
	<4E7B0E35.5010607@compulab.co.il>
	<CAF+7xW=AFmxCmppmt81pzkDbem=LAHdSYtT67yOOzMNPFRpnfA@mail.gmail.com>
Message-ID: <4E9C4DAE.7020804@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

On 09/29/11 10:57, Axel Lin wrote:
> 2011/9/22 Igor Grinberg <grinberg@compulab.co.il>:
>> Hi Axel,
>>
>> On 09/17/11 17:15, Axel Lin wrote:
>>> Fix below build warning and properly set bt_reset pin.
>>>
>>>   CC      arch/arm/mach-pxa/cm-x300.o
>>> arch/arm/mach-pxa/cm-x300.c: In function 'cm_x300_init_wi2wi':
>>> arch/arm/mach-pxa/cm-x300.c:779: warning: unused variable 'wlan_en'
>>> arch/arm/mach-pxa/cm-x300.c:795: warning: 'bt_reset' may be used uninitialized in this function
>>
>> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
>>
>> Also, this patch fixes a real regression since
>> 5a009df1f200efa49658b0e9c7ad056d59fbefe4 (ARM: pxa/cm-x300: GPIO cleanup)
>> - Wifi and Bluetooth do not work without it, so please:
>>
>> Cc: <stable@kernel.org> [3.0.x]
>>
> Hi, Eric,
> Just to pin the status of this patch. I think it should go for 3.1.
> Thanks,
> Axel
> 

-- 
Regards,
Igor.
