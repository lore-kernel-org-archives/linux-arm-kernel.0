From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 1 Feb 2018 10:49:46 +0530
Subject: [RESEND] phy: da8xx-usb: rename clock con_ids
In-Reply-To: <dbf02743-10ee-ccce-5f9c-2be8de075832@ti.com>
References: <1516731283-26388-1-git-send-email-david@lechnology.com>
 <dbf02743-10ee-ccce-5f9c-2be8de075832@ti.com>
Message-ID: <6630e9e4-f2b9-1c2c-b301-cf0db15a7ea1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 January 2018 09:11 PM, Sekhar Nori wrote:
> On Tuesday 23 January 2018 11:44 PM, David Lechner wrote:
>> This renames the clock con_ids in the DA8XX USB PHY driver as well as
>> the matching names in the mach clock registration code.
>>
>> This is in preparation for using device tree clocks where these names
>> will become part of the device tree bindings. The new names more closely
>> match the names used in the USB clock diagram in the SoC TRM.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Looks good to me.
> 
> Kishon, like with the other patch touching phy-da8xx-usb.c, I would like
> to queue this through my tree and provide an immutable commit to you.
> Let me know.

sure.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks,
> Sekhar
> 
