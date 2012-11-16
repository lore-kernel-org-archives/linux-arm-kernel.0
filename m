From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Nov 2012 10:00:50 +0100
Subject: [PATCH 0/6] Add basic support for Allwinner A1X SoCs
In-Reply-To: <201211160751.18401.arnd@arndb.de>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <201211160751.18401.arnd@arndb.de>
Message-ID: <50A600C2.8030006@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/16/2012 08:51 AM, Arnd Bergmann wrote:
> On Thursday 15 November 2012, Maxime Ripard wrote:
>> You'll find in this patchset the initial support for Allwinner A10 and A13 SoCs
>> from Allwinner. Since the internal name of these SoCs are sun4i and sun5i, the
>> mach- directory is named sunxi.
>>
>> You can find these SoCs in the Cubieboard, the A13-olinuxino or the Melee
>> A1000.
>>
>> Both SoCs should work fine, as the A13 is a trimmed down version of the A10,
>> but it has only been tested on a A13-OlinuXino from Olimex.
>>
>> Support is quite minimal for now, since it only includes timer and IRQ
>> controller drivers, so we can only boot to userspace through initramfs. Support
>> for the other peripherals on these SoCs will come eventually.
> 
> Hi Maxime,
> 
> Thanks for sending these, I'm pretty excited we actually get this far
> for 3.8. All patches look good for inclusion from my side, but I'll let
> Stefan and others comment first and then take your second version. We
> are getting closer to the merge window already, so I'd like to pull
> it in rather soon and maybe add some fixups later.

Yes, that would be great. I can send some patches to add A10/cubieboard
support in a few days.

> I've also ordered a Cubieboard myself now, so hopefully I'll also find
> some time to play with this.

Nice.

Thanks,
Stefan
