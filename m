From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Jan 2013 11:45:35 +0200
Subject: [PATCH v7 01/22] mfd: omap-usb-host: Consolidate OMAP USB-HS
 platform data
In-Reply-To: <20130117165943.GI14149@atomide.com>
References: <1358422231-24736-2-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301171016090.1339-100000@iolanthe.rowland.org>
 <20130117165943.GI14149@atomide.com>
Message-ID: <50F919BF.9050109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 06:59 PM, Tony Lindgren wrote:
> * Alan Stern <stern@rowland.harvard.edu> [130117 07:19]:
>> On Thu, 17 Jan 2013, Roger Quadros wrote:
>>
>>> Let's have a single platform data structure for the OMAP's High-Speed
>>> USB host subsystem instead of having 3 separate ones i.e. one for
>>> board data, one for USB Host (UHH) module and one for USB-TLL module.
>>>
>>> This makes the code much simpler and avoids creating multiple copies of
>>> platform data.
>>>
>>> CC: Alan Stern <stern@rowland.harvard.edu>
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> For the ehci-omap.c part:
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> If Samuel acks this patch, I can apply just this patch alone on v3.8-rc3
> into an immutable branch omap-for-v3.9/board-usb so we all merge it in
> as needed.
> 

I'll be sending a v8 of this series with one stable patch candidate
before this patch and Felipe's comments addressed.

--
cheers,
-roger
