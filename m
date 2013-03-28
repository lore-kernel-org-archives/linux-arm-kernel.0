From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 15:28:37 +0000
Subject: [PATCH v7 0/5] Add DT support for davinci_mmc driver
In-Reply-To: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Message-ID: <201303281528.37228.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Manjunathappa, Prakash wrote:
> 
> Patch set adds DT support for davinci_mmc driver and is
> verified on da850-evm without card_detect/write_protect and
> EDMA support. Also takecare to derive controller IP version from
> platform_device_id table, remove version specification in pdata.
> 
> Applies on top of below patch series under community review:
> "Enable SPI flash support on da850-evm DT kernel"
> http://www.spinics.net/lists/arm-kernel/msg231546.html
> 
> This series is reviewed and tested by Sekhar Nori, with and
> without DT on da850 EVM.

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Since v6:
> Add DMA handling capability, but not tested.

What I was asking for was actually just adding the description to the
binding documentation, not also to the code, but the code does look
correct to me, so this is fine, too.

	Arnd
