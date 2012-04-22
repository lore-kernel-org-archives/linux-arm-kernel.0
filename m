From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 21:28:21 +0000
Subject: [GIT PULL] LPC32xx: Device tree conversion
In-Reply-To: <4F93DFB0.4040409@antcom.de>
References: <4F93DFB0.4040409@antcom.de>
Message-ID: <201204222128.21993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 April 2012, Roland Stigge wrote:
> Hi Arnd and Olof,
> 
> this is a rearrangement of all mach-lpc32xx specific patches for device
> tree conversion. Please note that:
> 
> * It builds upon the i2c-pnx changes (see previous pull request, branch
>   lpc32xx/i2c)
> * Dave Miller gave permission to merge the lpc_eth.c change via arm-soc
>   (patch 1/8)
> 
> The rest of the patches is mach-lpc32xx only.

Pulled into the next/dt branch, with the i2c patches being stored in
the depends/i2c/lpc32xx branch for reference.

Thanks,

	Arnd
