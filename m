From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 2 Aug 2015 14:58:11 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun7i: Add dts file for
 Wits Pro A20 DKT
In-Reply-To: <20150801093046.GX2564@lukather>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-6-git-send-email-hdegoede@redhat.com>
 <20150731102028.GE2564@lukather>
 <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
 <55BB9E92.30604@redhat.com> <20150801093046.GX2564@lukather>
Message-ID: <55BE13E3.8060503@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-08-15 11:30, Maxime Ripard wrote:
> On Fri, Jul 31, 2015 at 06:13:06PM +0200, Hans de Goede wrote:
>> mmc-pwrseq-simple supports multiple reset/enable gpios (by listing
>> them all as reset-gpios and setting GPIO_ACTIVE_LOW/HIGH depending
>> on which value they need to be to activate things).
>>
>> It also supports listing clocks which need to be enabled. I think
>> that it may be a good idea to use this to also enable the bluetooth
>> bits of the ap6210 module on the cubietruck. I know that the
>> actual bt is interfaced over an uart, and we really should have
>> a mechanism to enable/disable it separately, but for not this seems
>> like a good way to get bluetooth to work.
>>
>> We should ofcourse add a comment to the dts file that this is not a
>> 100% ideal solution, but other then that I think this should work
>> nicely. Maxime would enabling the bluetooth bits of this sdio
>> module via mmc-pwrseq be acceptable to you?
>
> As long as we have some comment on top, yep.

Great, thanks.

>> ChenYu if Maxime acks this solution I hope you can write a patch for
>> this, since you've been working on the bluetooth support before.
>
> Note that I'm in holidays starting today. I plan on doing my
> pull-requests for 4.3 later today, and will probably not be able to
> merge any patches during the next two weeks, which mean that your
> mmc-power seq patch for the cubietruck was probably the last one I was
> merging for the 4.3 merge window.

OK, that is good to know, thanks for the headsup and enjoy your hollidays.

Regards,

Hans
