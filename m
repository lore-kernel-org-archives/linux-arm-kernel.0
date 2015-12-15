From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 17:41:46 +0100
Subject: [GIT PULL] MTD/NAND cleanups for v4.5
In-Reply-To: <20151208031306.GP120110@google.com>
References: <20151208031306.GP120110@google.com>
Message-ID: <5642518.pVxm48RVvl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 19:13:06 Brian Norris wrote:
> Two changes for NAND/MTD refactoring. The mtd_to_nand() helper will allow us to
> stop using mtd->priv for NAND drivers.
> 
> 

I've put this into the next/cleanup branch in arm-soc as well now,
so we can see when we get conflicts, and work around them locally.

Thanks,

	Arnd
