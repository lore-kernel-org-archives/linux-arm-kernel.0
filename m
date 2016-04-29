From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Apr 2016 14:17:45 -0700
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160429211328.GZ19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
 <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 29, 2016 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 01:04:48PM -0700, Doug Anderson wrote:
>> Russell,
>>
>> On Fri, Apr 29, 2016 at 12:57 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >> * Presumably on a PC you've got an extra bit in the middle (like grub
>> >> or something like that) that can help you resolve your UUIDs even if
>> >> you get your kernel from somewhere else.
>> >
>> > You are over-estimating what grub does.  Grub doesn't resolve UUIDs at
>> > all.  Grub just passes the kernel arguments in its configuration file
>> > for the entry it is booting to the kernel.  It's a static configuration
>> > found in /boot/grub/grub.conf.
>> >
>> > It doesn't probe devices for UUIDs.
>>
>> OK.  The point was: if folks on PCs have a workflow that works for
>> them, wonderful.  That workflow doesn't work so great for me.  My
>> workflow doesn't hurt them.  Why is it bad?
>
> This discussion is over, since you're not willing to actually discuss
> it (illustrated by you cutting and pasting this same thing four
> times in your reply.)
>
> My NAK stands until such time that you can partake in a reasonable
> discussion.

The point of pasting it several times was that you'd answer it.
Apparently that failed.

Perhaps you could answer the question I posed?

-Doug
