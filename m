From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 15:56:34 +0200
Subject: NXP LPC32xx Mach Updates for v4.7
In-Reply-To: <572292E4.9010209@mleia.com>
References: <572292E4.9010209@mleia.com>
Message-ID: <4494663.PrONKa9Wrp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 01:47:00 Vladimir Zapolskiy wrote:
> NXP LPC32xx mach updates for v4.7
> 
> This includes a few nonfunctional clean-ups for NXP LPC32xx:
> * removed leftover from restart code migration to a watchdog driver
> * removed dead code leftovers from migration to CCF driver
> * fix double const qualifier
> 

Merged into next/soc, thanks!

	Arnd
