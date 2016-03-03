From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 13:23:31 +0100
Subject: [PATCH 00/17] Add Initial support for PLX Technology OX810SE
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <2685005.KXG3SqulNM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 12:39:53 Neil Armstrong wrote:
> This serie adds initial support (IRQ, Timer, GPIO, Reset, Serial, Clocks) for
> the PLX Technology OX810SE used in the well-known Western Digital My Book
> World Edition Network Attached Storage device.
> 
> Extended support for SATA, DMA and Ethernet will come in further patches.
> 
> Upstream support for following devices like the OX820SE is welcome !
> 

Looks very nice overall. I think with the timing, it's a way too
late for 4.6 now, but there should be no problem merging this for 4.7.
I assume it's not urgent on your end, as this seems to be a somewhat
historic platform.

I had no idea there was an ARM9 based predecessor of OX820SE, so I was
surprised to see this one instead. How closely related are they?

	Arnd
