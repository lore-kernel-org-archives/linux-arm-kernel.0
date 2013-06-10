From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 10 Jun 2013 18:13:12 +0530
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
In-Reply-To: <51B58FE9.5040309@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
Message-ID: <51B5C9E0.1090704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On Monday 10 June 2013 02:05 PM, Lokesh Vutla wrote:
> Hi Kevin,
>
> On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>>>
>>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>
>>>> AM33XX only supports DT boot mode and with addition of
>>>> extracting module resources like, irq, dma and address space
>>>> from DT block, so now we can remove duplicate information from
>>>> hwmod data file.
>>>
>>> OK, guess I'll take your word for it that it all works.  The
>>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
>>> And the BeagleBone-black with discrete DTB doesn't boot at all with
>>> current mainline, only with the TI vendor kernel & DTB...
>>
>> Anyone care to shed light on what's missing for BeagleBone boot with
>> mainline currently?
> I have tested BeagleBone boot with today's mainline bootloader and
> kernel. It boots perfectly fine.
I have taken the boot log for BeagleBone from the folllowing site:
http://www.pwsan.com/omap/testlogs/test_v3.10-rc5/20130609031534/boot/am335xbone/

I have reset to your U-Boot commit id and took latest mainline kernel.
It boots fine in my setup.
You can find the logs here: http://pastebin.com/ggVYs3RG

Thanks and regards,
Lokesh
>
> Thanks and regards,
> Lokesh
>>
>> I've also not been able to boot a mainline kernel on the BeagleBone for
>> some time.
>>
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
