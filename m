From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 18 Feb 2011 13:47:26 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102181444.24476.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
	<201102181444.24476.arnd@arndb.de>
Message-ID: <AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 7:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I'm curious. Neither the manfid nor the oemid fields of either card
> match what I have seen on SD cards, I would expect them to be
>
> Sandisk: manfid 0x000003, oemid 0x5344
> Toshiba: manfid 0x000002, oemid 0x544d
>
> I have not actually seen any Toshiba SD cards, but I assume that they
> use the same controllers as Kingston.
>
> Does anyone know if the IDs have any correlation between MMC and SD
> controllers?
>
> ? ? ? ?Arnd
>

I'm unsure about the older scheme (assigned by MMCA), but ever since
MMC is now JEDEC-controlled, the IDs have changed. Sandisk's new id
will be 0x45, and Toshiba I guess will be 0x11.
