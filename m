From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Jul 2014 08:22:10 -0700
Subject: [PATCH 3/3] ARM: dts: Enable USB host0 (EHCI) on rk3288-evb
In-Reply-To: <4280303.LVm1cg0Iss@diego>
References: <1406676273-20701-1-git-send-email-dianders@chromium.org>
 <1406676273-20701-4-git-send-email-dianders@chromium.org>
 <4280303.LVm1cg0Iss@diego>
Message-ID: <CAD=FV=W1HGxTDx6k7tizZ_Ez3GsxmwV0t5gJx0fanAQ2t_fnuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jul 30, 2014 at 4:26 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 29. Juli 2014, 16:24:33 schrieb Doug Anderson:
>> This is the top USB port on the evb (the one closest to the Ethernet
>> connector).
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> shouldn't the signed-offs be the other way around, like in patch 2/3?

I wasn't aware that the order was too relevant, but I'll happily swap
them.  I generally try to list them based on contribution.  Things get
complicated when lots of WIP patches are sent around and then someone
eventually puts things together.  My work enabling the EHCI port was
based on something Kever sent me in email, so I felt he should have
SoB.  ...but cleaning it up / organizing was done by me.  Probably
should be this to get it totally right:

* Patch #1: Author and SoB are me, since Kever just pointed me to the
GPIO number
* Patch #2: Probably should be author Kever, first SoB Kever, second SoB me
* Patch #3: Probably should be author me, first SoB me, second SoB Kever

...in that case I just need to tweak the author of Patch #2 and leave
everything else the same.  I'll plan to do that when I repost.

...but I don't really care a whole lot and I'm OK with any authorship
of patch set #2/#3 and any SoB order of patch set #2/#3.  Just let me
know which you prefer!  :)

-Doug
