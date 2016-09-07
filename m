From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 17:24:49 +0200
Subject: [PATCH] arm64: Remove shadowed asm-generic headers
In-Reply-To: <4c44ef91680ce29dd1c45ef8de846d94f197d381.1473260551.git.robin.murphy@arm.com>
References: <4c44ef91680ce29dd1c45ef8de846d94f197d381.1473260551.git.robin.murphy@arm.com>
Message-ID: <3232408.qR5z6UhKu2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 4:02:31 PM CEST Robin Murphy wrote:
> We've grown our own versions of bug.h, ftrace.h, pci.h and topology.h,
> so generating the generic ones as well is unnecessary and a potential
> source of build hiccups. At the very least, having them present has
> confused my source-indexing tool, and that simply will not do.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
