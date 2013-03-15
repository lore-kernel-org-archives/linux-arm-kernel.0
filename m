From: kishon@ti.com (kishon)
Date: Fri, 15 Mar 2013 19:03:04 +0530
Subject: [PATCH v3 0/7] ARM: dts: omap: Add dts data for USB
In-Reply-To: <514316FA.1090002@ti.com>
References: <1362663320-23799-1-git-send-email-kishon@ti.com>
 <514316FA.1090002@ti.com>
Message-ID: <51432310.7050201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013 06:11 PM, Benoit Cousson wrote:
> + Jon
>
> Hi Kishon,
>
> On 03/07/2013 02:35 PM, Kishon Vijay Abraham I wrote:
>> Hi Benoit,
>>
>> Here are the dt data patches to get usb device functional in OMAP platforms.
>>
>> All the patches deal with modifying arch/arm/boot except one which modifies
>> Documentation/../usb/omap-usb.txt
>>
>> Changes from v2:
>> * squashed the dt data for dwc3-omap with dwc3 core into a single patch.
>>
>> Changes from v1:
>> Patch *ARM: dts: omap: Add usb_otg and glue data* has some properties with
>> names that has "_". It's replaced with a "-" here.
>>
>> This patch is developed on Linux 3.9-rc1.
>
> The patches looks really good. I've just had to rebase on top of my HEAD due to some conflict with GPMC patch already applied.
>
> I cleaned as well some subject and changelog for consistency.

Ok. Thanks :-)

Regards
Kishon
