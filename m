From: John.Youn@synopsys.com (John Youn)
Date: Thu, 18 Aug 2016 12:34:27 -0700
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1882785986.365355.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
 <722dafcb-2f67-88c7-69df-d442c56c058f@synopsys.com>
 <263309088.290419.51598113-17aa-4db0-9dc0-6e58e3fafe07.open-xchange@email.1und1.de>
 <ac20c0e9-0cab-7e3f-4abf-75223538a816@synopsys.com>
 <1270178266.398560.152fe5dd-527b-4ad6-b2fd-e4b0af6bc2a9.open-xchange@email.1und1.de>
 <badc3aa5-29ac-9b8c-2531-564c44b60030@synopsys.com>
 <85508461.401578.b150078c-11e6-4a32-b9b6-f40bf8417708.open-xchange@email.1und1.de>
 <400e11e7-8263-17d8-5c22-8b1c3a0878e7@synopsys.com>
 <1882785986.365355.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
Message-ID: <e40cdc61-16ea-c86d-0039-7c24a123c058@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2016 12:04 PM, Stefan Wahren wrote:
> Hi John,
> 
>> John Youn <John.Youn@synopsys.com> hat am 18. August 2016 um 20:03
>> geschrieben:
>>
>>
>> On 8/17/2016 3:17 PM, Stefan Wahren wrote:
>>> Hi John,
>>>
>>>> John Youn <John.Youn@synopsys.com> hat am 17. August 2016 um 23:21
>>>> geschrieben:
>>>>
>>>>
>>>> ...
>>>> Ok, yeah, that seems better.
>>>>
>>>> Can you check if applying just patch 2 and 3 solves the issue? If so I
>>>> think we can send those upstream.
>>>
>>> unfortunately not:
>>
>> Ok. I'll see if I can come up with a more conservative version of
>> patch 4 until I can look at it properly. I'll try to get to this
>> sometime next week but I may not be able to get to it until later.
> 
> Great
> 
>>
>> In the meantime, specifying the fifo sizes as you've done can serve as
>> a workaround.
> 
> Beside of this workaround, do you see any benefit of patch 2/6 from my series?
> 
> I don't want to introduce DT properties which are only useful for workarounds?

Does everything work fine if you don't set any parameters, and use my
patches from before? If so, and if you're willing to wait for the fix
to those patches then I don't see a need for it.

They would be useful beyond a workaround, if only for our internal
test platform, but we don't need it right away.

Regards,
John
