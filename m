From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 14:24:03 +0100
Subject: [PATCHv1 0/3] arm: mvebu: add Synology DS213j and DS414 .dts files
In-Reply-To: <20141116022035.GE15870@lunn.ch> (Andrew Lunn's message of "Sun,
 16 Nov 2014 03:20:35 +0100")
References: <cover.1416095841.git.arno@natisbad.org>
 <20141116022035.GE15870@lunn.ch>
Message-ID: <874mtzb7nw.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Lunn <andrew@lunn.ch> writes:

>> Andrew, in this v1, the two .dts files are still separate w/o any common
>> .dtsi. I took a quick look it seems there are small differences between
>> the two which make me wonder if its worth the trouble:
>> 
>>  - DS414 fans are not handled by the SoC
>>  - various pinctrl variations
>>  - a tiny difference in SPI flash partitioning
>>  - phy-mode for ethernet interfaces
>>  - different comments associated w/ same nodes (e.g. uart1)
>>  - etc
>
> O.K, lets wait for the moment. It could be that there is more in
> common between different 370 devices, and between different XP
> devices, but less in common across 370 and XP.
>
> We can refactor it later when a pattern starts to appear.

ok.


>>  - Added a comment in the .dts file about the bootloader screwing the kernel
>>    if the environment is saved.
>
> Is this well know in the forums? Do you think Synology knows about it?
> It would be nice if it was fixed. Maybe not for these products, but
> for the next generation.

I never went to synology forum to check if someone had broken her NAS
doing a saveenv under u-boot. But I doubt that: doing a 'synology saveenv'
search on google gives DS213j .dts submission (with the comment on the
issue) as 10th link.

If you have some contact to provide, I can report it.

Cheers,

a+
