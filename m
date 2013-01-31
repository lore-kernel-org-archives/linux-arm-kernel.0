From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 31 Jan 2013 20:28:26 +0100
Subject: [PATCH v3] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <20130131175743.GF7717@titan.lakedaemon.net>
References: <3816648.2TVsTiMOWx@bender>
 <1358174852-19752-1-git-send-email-florian@openwrt.org>
 <20130131175743.GF7717@titan.lakedaemon.net>
Message-ID: <510AC5DA.5070505@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 31/01/2013 18:57, Jason Cooper a ?crit :
> Florian,
>
> On Mon, Jan 14, 2013 at 03:47:32PM +0100, Florian Fainelli wrote:
>> This patch adds the DTS file to support the Marvell RD-A370-A1
>> (Reference Design board) also known as RD-88F6710 board. It is almost
>> entirely similar to the DB-A370 except on the following points:
>>
>> - second Ethernet MAC is connected to a switch using RGMII
>> - it only has 512MB of physical RAM
>> - SDIO interface is enabled and working by default (no need for jumpers)
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>> Jason,
>>
>> This is rebased against your mvebu/for-next branch, can you please drop v2 of
>> the previous patch and take this one instead? Thanks!
>>
>> Changes since v2:
>> - rebased against Jason's mvebu/for-next
>> - added SDIO bindings
>> - changed commit message a bit
>
> This breaks badly as sdio bindings aren't added until mvebu/dt.  Since
> this is a new board, it goes in *before* mvebu/dt (mvebu/boards).  I'm
> going to go ahead and pull v2 instead as there seems to be no
> significant difference other than mvsdio being added.

Whoops, sounds like the right thing to do, thanks!

>
> If you want to get sdio support in for v3.9, please submit a separate
> patch on top of your v2.

Will do.
--
Florian
