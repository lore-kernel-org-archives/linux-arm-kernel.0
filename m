From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 24 Mar 2016 12:15:52 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: Base Orange Pi Plus
 dts on the Orange Pi 2 dts
In-Reply-To: <20160324075904.GU30977@lukather>
References: <1458771256-4069-1-git-send-email-hdegoede@redhat.com>
 <20160324075904.GU30977@lukather>
Message-ID: <56F3CC68.4010705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 24-03-16 08:59, Maxime Ripard wrote:
> Hi,
>
> On Wed, Mar 23, 2016 at 11:14:16PM +0100, Hans de Goede wrote:
>> The Orange Pi Plus really is an Orange Pi 2 extended with:
>> 1) A sata <-> usb bridge connected to ehci3
>> 2) An eMMC on mmc2
>> 3) An external gigabit ethernet phy instead of the integrated 100Mbit phy
>>
>> This commit changes the dts to reflect this by making it include
>> the Orange Pi 2 dts and then adding the extra bits.
>>
>> Note that the difference in ethernet phy is not taken into account
>> because we do not have an ethernet driver for the H3 yet.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Unfortunately, the patch doesn't apply anymore, and the merge doesn't
> seem trivial.
>
> I pushed my branch on my kernel.org repo, can you rebase your patch on
> top and resend it?

The problem is that you forgot to apply:
"ARM: dts: sun8i: Orangepi plus gpio keys fixes and improvements"

With that applied this one should apply unchanged too.

Regards,

Hans
