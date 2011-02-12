From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Feb 2011 19:22:22 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTikxMKm-Xy5du2+MzrD2eLuvfO9hXrSzBKmAkdBm@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102121805.47311.arnd@arndb.de>
	<AANLkTikxMKm-Xy5du2+MzrD2eLuvfO9hXrSzBKmAkdBm@mail.gmail.com>
Message-ID: <201102121922.22055.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 February 2011 18:33:10 Andrei Warkentin wrote:
> On Sat, Feb 12, 2011 at 11:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 11 February 2011 23:33:42 Andrei Warkentin wrote:
> >> On Wed, Feb 9, 2011 at 3:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
> >>
> >> cid - 02010053454d3332479070cc51451d00
> >> csd - d00f 0032 0f59 03ff ffffffff92404000
> >> erase_size - 524288
> >> fwrev - 0x0
> >> hwrev - 0x0
> >> manfid - 0x000002
> >> name - SEM32G
> >> oemid - 0x0100
> >> preferred_erase_size - 2097152
> >
> 
> This is a Toshiba eMMC part. It is 32GB as far as the OS can see and access.

Ah, right, that explains all the values, which make sense for eMMC4
but not for SDHC ;-)

	Arnd
