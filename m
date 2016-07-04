From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 4 Jul 2016 13:20:15 +0530
Subject: [PATCH v5 resend 0/2] phy-sun4i-usb: peripheral-mode + a31 otg
 workaround
In-Reply-To: <5390a35e-e043-6440-9a1c-5e34a41c2992@redhat.com>
References: <1467224050-7480-1-git-send-email-hdegoede@redhat.com>
 <5774B26E.5010609@ti.com> <5390a35e-e043-6440-9a1c-5e34a41c2992@redhat.com>
Message-ID: <577A1537.2050802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sunday 03 July 2016 01:38 AM, Hans de Goede wrote:
> Hi,
> 
> On 30-06-16 07:47, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 29 June 2016 11:44 PM, Hans de Goede wrote:
>>> Hi Kishon,
>>>
>>> The "USB: Fix of_usb_get_dr_mode_by_phy with a shared phy block"
>>> patch on which this series depends is in usb-next now:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ce15ed4c5dfb3f7757e6611902aed5db253af977
>>>
>>>
>>> Can you please merge this series?
>>
>> This is not applying cleanly against linux-phy -next. Can you rebase and send?
> 
> I just tried to rebase, the problem is that your -next branch does not
> contain the fixes from your -fixes branch, specifically it is missing
> this commit:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/phy?id=5cf700ac9d50353dc5b8194a57c6f40bf1fc4424
> 
> 
> Which is causing the conflict you're seeing when trying to merge
> the patches I send. I can send you fixed patches which apply
> cleanly to your linux-phy/next but those then will not merge
> properly with linus' tree.
> 
> So it is probably better to at least cherry-pick the commit
> I've linked to above into your -next, to avoid future merge
> problems. If you cherry-pick that commit then the patches
> I've send you should apply cleanly.

Ah okay.. I'll rebase my next onto my fixes. Thanks for letting me know this.

Thanks
Kishon
