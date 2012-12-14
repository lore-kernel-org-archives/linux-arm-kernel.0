From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 14 Dec 2012 18:10:43 +0100
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
In-Reply-To: <201212131200.48413.arnd@arndb.de>
References: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
 <201212131200.48413.arnd@arndb.de>
Message-ID: <50CB5D93.7080405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Le 13/12/2012 13:00, Arnd Bergmann a ?crit :
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

Will you take it directly, or do you want a pull request?

> Side note:
> I just read about the A20 and A31, is there any information and/or
> source code available for those already, or are they again kept
> hidden by Allwinner?

There's been a tablet announced with an A31 running Android (the Onda
V972), so I guess we can expect a source drop sometime soon, but for the
A20, I don't know. It looks like Allwinner even removed all references
to that SoC on their website, so...

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
