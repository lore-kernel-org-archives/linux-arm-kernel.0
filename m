From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2016 16:45:12 +0200
Subject: [PATCH] smc91x: remove ARM hack for unaligned 16-bit writes
In-Reply-To: <20160825144314.1850730-1-arnd@arndb.de>
References: <20160825144314.1850730-1-arnd@arndb.de>
Message-ID: <3062310.z9h3CgCZ7p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 25, 2016 4:43:04 PM CEST Arnd Bergmann wrote:
>  drivers/net/ethernet/smsc/smc91x.h | 50 +++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> While this patch fixes one bug on Neponset, it probably doesn't address
> the one that Russell ran into first, so this is for review only for now,
> until the remaining problem(s) have been worked out.
> 

The comment should have been on another patch, my mistake. please
see v2.

	Arnd
