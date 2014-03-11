From: rogerq@ti.com (Roger Quadros)
Date: Tue, 11 Mar 2014 15:10:33 +0200
Subject: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
In-Reply-To: <20140311130715.GM21216@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com> <20140311120259.GI21216@lee--X1>
 <531EFE97.1090202@ti.com> <20140311130715.GM21216@lee--X1>
Message-ID: <531F0B49.2070008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 03:07 PM, Lee Jones wrote:
> 
>>>>> This patchset brings up USB Host ports and Ethernet port on
>>>>> the OMAP5 uEVM board.
>>>>>
>>>>> It also does some cleanup with respect to DT clock binding
>>>>> for the mfd/omap-usb-host driver.
>>>>>
>>>>> Please queue these for -next.
>>>>>
>>>>> Lee,
>>>>>
>>>>> I've folded some platform data dependent patches with mfd patches
>>>>> so that they don't break functionality when applied individually.
>>>>> You can safely pull in all MFD patches (1 to 6).
>>>>>
>>>>> Tony & Benoit,
>>>>>
>>>>> Can you please accept patches 7, 8 and 9?
>>>>
>>>> Tony has already picked up 7,8 and 9 through omap-soc tree.
>>>>
>>>> Since you acked most patches except 5 and 6, are you fine if Tony takes
>>>> all the patches 1 to 4 in this series via omap-soc tree?
>>>>
>>>> What about patches 5 and 6?
>>>
>>> Any patches which are orthogonal can just be sucked into whichever tree
>>> they belong in. If there are inter-subsystem dependencies I'd prefer
>>> to take them and issue a immutable branch pull-request to the other
>>> maintainers.
>>>
>> Awesome. That would be great, thanks.
> 
> That does mean I need a) all of the Maintainer Acks and b) you to tell
> me which ones need to go through a single tree.
> 

You need to take patches 1 to 6 in the MFD tree. Out of these, patches 1 to 4
need to be shared with Tony as an immutable branch.

Tony, could you please Ack patches 1 to 4? Thanks.

cheers,
-roger
