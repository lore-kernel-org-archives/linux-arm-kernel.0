From: andreiw@motorola.com (Andrei Warkentin)
Date: Thu, 17 Feb 2011 19:10:18 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Message-ID: <AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 4:33 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Arnd,
>
> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
>
> cid - 02010053454d3332479070cc51451d00
> csd - d00f00320f5903ffffffffff92404000
> erase_size - 524288
> fwrev - 0x0
> hwrev - 0x0
> manfid - 0x000002
> name - SEM32G
> oemid - 0x0100
> preferred_erase_size - 2097152
>

Ok. Big mistake. Sorry about that. This card is Sandisk card. I got
confused over all the manfids changing.

Here is the Toshiba card:

cid - 1101004d4d4333324703101a17746d00
csd - 900e00320f5903ffffffffe796400000
erase_size - 524288
fwrev - 0x0
hwrev - 0x0
manfid - 0x000011
name - MMC32G
oemid - 0x0100
preferred_erase_size - 4194304

I'll get you the flashbench timings for both.
