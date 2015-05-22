From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:40:17 +0200
Subject: [GIT PULL] at91: cleanup for 4.2 #1
In-Reply-To: <20150522090534.GA499@piout.net>
References: <20150522090534.GA499@piout.net>
Message-ID: <18530933.QYLDvn3ehc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 11:05:34 Alexandre Belloni wrote:
> First batch of cleanup for 4.2:
>  - use syscon in the ata and cf drivers to configure the SMC and drop
>  sam9_smc.c
>  - switch the at91rm9200 memory controller to syscon
>  - remove last useless headers
>  - remove now useless Makefile.boot

Nice!

Merged into next/cleanup, thanks

	Arnd
