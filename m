From: rogerq@ti.com (Roger Quadros)
Date: Mon, 3 Mar 2014 11:34:52 +0200
Subject: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
In-Reply-To: <20140228225627.GU13624@atomide.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <20140228225627.GU13624@atomide.com>
Message-ID: <53144CBC.2050607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 03/01/2014 12:56 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [140227 06:21]:
>> Hi,
>>
>> This patchset brings up USB Host ports and Ethernet port on
>> the OMAP5 uEVM board.
>>
>> It also does some cleanup with respect to DT clock binding
>> for the mfd/omap-usb-host driver.
>>
>> Please queue these for -next.
>>
>> Lee,
>>
>> I've folded some platform data dependent patches with mfd patches
>> so that they don't break functionality when applied individually.
>> You can safely pull in all MFD patches (1 to 6).
>>
>> Tony & Benoit,
>>
>> Can you please accept patches 7, 8 and 9?
> 
> Are 7, 8 and 9 safe to queue separately from the MFD changes
> or do they need to wait for the MFD changes to get merged
> first?
> 

They are safe to queue separately.

cheers,
-roger
