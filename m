From: amery@geeks.cl (Alejandro Mery)
Date: Sat, 15 Dec 2012 00:34:57 +0100
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
In-Reply-To: <201212131200.48413.arnd@arndb.de>
References: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
 <201212131200.48413.arnd@arndb.de>
Message-ID: <50CBB7A1.5000201@geeks.cl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/12 13:00, Arnd Bergmann wrote:
> On Wednesday 12 December 2012, Maxime Ripard wrote:
>> There is several different SoCs sharing the sun5i codename: A10s, A12
>> and A13. Since there is enough differences to not consider those the
>> same SoCs, change a bit the naming scheme to reflect this.
>>
>> Moreover, some boards like the olinuxino come in A10s and A13 variants,
>> which also share the same SoC codename.
>>
>> So change the naming scheme to reflect both the codename and the market
>> name of the SoCs used in the dtsi and in the board files
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Side note:
> I just read about the A20 and A31, is there any information and/or
> source code available for those already, or are they again kept
> hidden by Allwinner?

currently they don't even sell A20 samples, and it was mostly removed 
from their website (to not compete with the A31 I suppose). for the A31 
Tsvetan (olimex.com) was told not even the short datasheet (pins and 
features) is written yet, and no devkits are available. All A31-based 
products currently designed (PCBs) and integrated (android) within 
Allwinner walls.

Chances are very high that the SDKs for these are similar to sun5i ones, 
i.e. with all allwinner code provided as .o/.ko only... and just enough 
.h files to be able to compile drivers.

<rant>ARM should *force* all their licensees to respect the GPL. They 
are profiting for this immoral negligence and that puts ARM itself in 
the same bucket.</rant>

cheers,
Alejandro Mery
