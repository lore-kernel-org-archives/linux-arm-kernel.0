From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 28 Jul 2015 16:24:58 +0200
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150728124911.GA2564@lukather>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com>
 <55B62768.6040403@redhat.com> <20150728124911.GA2564@lukather>
Message-ID: <55B790BA.5000509@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/28/2015 02:49 PM, Maxime Ripard wrote:
> Hi,
>
> On Mon, Jul 27, 2015 at 02:43:20PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 27-07-15 14:09, public_timo.s at silentcreek.de wrote:
>>> Hi,
>>>
>>> Hans de Goede schrieb am 27.07.2015 10:07:
>>>
>>>> I've a simular patch here:
>>>>
>>>> https://github.com/jwrdegoede/linux-sunxi/commit/6a30b7d5be6012b81e5e1439a444e41c0ac1afc1
>>>>
>>>> I did not submit this upstream yet as it is part of a series to enable the otg
>>>> controller on the bananapi which needs axp-usb-power-supply support for which
>>>> the actual powersupply driver changes are still pending.
>>>
>>> Oops, I see. Are you planning to submit this for 4.3 or later?
>>
>> I plan to submit this for 4.3.
>
> I don't feel like holding patches that were posted before you did
> because you did them some time ago and never submitted them is
> reasonnable and / or encouraging for new submitters of patches.
>
> I'd really like to get more sunxi-people contributing, and that starts
> with that kind of trivial stuff. Holding them back because one of the
> usual (and experienced) developpers is a bit counter-productive (and
> I'm sure you still have a lot of patches to submit anyway ;)).

I've no problem with Timo submitting a cleaned up version of his
patch and you taking that instead. I just wanted to point out that
I do have a similar patch pending.

Regards,

Hans
