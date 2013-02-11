From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Feb 2013 22:46:55 -0800
Subject: [PATCH v7 01/22] mfd: omap-usb-host: Consolidate OMAP USB-HS
 platform data
In-Reply-To: <20130117165943.GI14149@atomide.com>
References: <1358422231-24736-2-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301171016090.1339-100000@iolanthe.rowland.org>
 <20130117165943.GI14149@atomide.com>
Message-ID: <CAOesGMhVeSPX2qWb+3Efo14Qbqmhrqpg1XRDnAfznHfAis-Fsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 8:59 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Alan Stern <stern@rowland.harvard.edu> [130117 07:19]:
>> On Thu, 17 Jan 2013, Roger Quadros wrote:
>>
>> > Let's have a single platform data structure for the OMAP's High-Speed
>> > USB host subsystem instead of having 3 separate ones i.e. one for
>> > board data, one for USB Host (UHH) module and one for USB-TLL module.
>> >
>> > This makes the code much simpler and avoids creating multiple copies of
>> > platform data.
>> >
>> > CC: Alan Stern <stern@rowland.harvard.edu>
>> >
>> > Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> For the ehci-omap.c part:
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> If Samuel acks this patch, I can apply just this patch alone on v3.8-rc3
> into an immutable branch omap-for-v3.9/board-usb so we all merge it in
> as needed.

So, that didn't happen; Samuel applied it from the mailing list and
sfr just hit merge conflicts due to it.

Sigh.

This patch (touching arch/arm/mach-omap2) didn't have acks from Tony either.

Samuel, Tony, can you sort this out with a stable short topic branch
as Tony suggested? It'd be nice to avoid the merge conflict by a
little coordination here. :(


-Olof
