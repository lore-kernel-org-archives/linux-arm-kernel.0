From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 11 Jun 2015 11:08:43 +0530
Subject: [PATCH v3 0/2] USB OTG PHY driver for NXP LPC18xx family
In-Reply-To: <CAGhQ9VzoZN0wow6csD7Mq58CFk31DGup676NoO=hyqnuAwNQwA@mail.gmail.com>
References: <1432922617-11512-1-git-send-email-manabian@gmail.com>
 <CAGhQ9VzoZN0wow6csD7Mq58CFk31DGup676NoO=hyqnuAwNQwA@mail.gmail.com>
Message-ID: <55791EE3.4040001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Thursday 11 June 2015 12:39 AM, Joachim Eastwood wrote:
> Hi Kishon,
>
> On 29 May 2015 at 20:03, Joachim Eastwood <manabian@gmail.com> wrote:
>> This patch set adds support for the internal USB OTG PHY found
>> on NXP LPC18xx and LPC43xx devices. Driver takes care of
>> enabling the PHY and setting the clock rate which is need for
>> USB0 support on this platform.
>>
>> This version address the comments from Kishon Vijay Abraham I.
>>
>> Changes in v3:
>>   - depend on MFD_SYSCON
>>
>> Changes in v2:
>>   - use PTR_ERR_OR_ZERO in phy driver
>>   - rename binding doc
>>   - update doc commit message
>>
>> Base support for this platform can now be found in arm-soc next.
>>
>> Joachim Eastwood (2):
>>    phy: add lpc18xx usb otg phy driver
>>    phy: dt bindings: add XP LPC18xx/43xx USB OTG PHY bindings
>
> Do you have any more comments on the patches or are they okey now?

The patches look fine. But it can go only in 4.3.

Thanks
Kishon
