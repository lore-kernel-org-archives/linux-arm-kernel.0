From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 16:37:24 +0100
Subject: [git pull] soc_device_match() interface for matching against
 soc_bus attributes
In-Reply-To: <1479904376-12453-1-git-send-email-geert+renesas@glider.be>
References: <1479904376-12453-1-git-send-email-geert+renesas@glider.be>
Message-ID: <27912062.8CdzEp3sLr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 1:32:56 PM CET Geert Uytterhoeven wrote:
> soc_device_match() interface for matching against soc_bus attributes
> 
> This provides core infrastructure as a dependency for several users
> (Freescale/NXP, Samsung, Renesas).
> 
> Its core parts have been acked by Greg, and the fixes by Arnd and/or
> Greg (the last fix only received an informal ack, that's why I hadn't
> added the ack).
> 
> This has already been pulled by Ulf, and is present in mmc/next, as a
> dependency for a Freescale/NXP driver update.
> 
> 

I've pulled this into next/drivers and also into a separate 
next/socdevice-match that we can use for keeping track. Thanks,

	Arnd
